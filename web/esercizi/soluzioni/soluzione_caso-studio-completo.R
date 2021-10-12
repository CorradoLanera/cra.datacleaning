library(here)
library(tidyverse)
library(readxl)
library(janitor)
library(unheadr)



# loading raw dataset ---------------------------------------------

raw_db <- here("data-raw/messy_aoe.xlsx") %>%
    read_xlsx(
        col_names = FALSE,
        na = c("", " ", "-")
    )



# Fix headers -----------------------------------------------------

header_db <- raw_db %>%
    remove_empty() %>%
    mash_colnames(4, keep_names = FALSE, sliding_headers = TRUE) %>%
    clean_names()

correct_names <- names(header_db) %>%
    str_replace("t1_line_of_sigth", "t1_line_of_sight")
names(header_db) <- correct_names
header_db


# Consistent case/string ------------------------------------------

consistent_strings <- header_db %>%
    mutate(
        across(everything(), str_squish),
        across(c(name, info_type, info_age), str_to_title)
    )
consistent_strings


# broken names ----------------------------------------------------


name_fixed <- consistent_strings %>%
    unbreak_vals("^\\(", name, name_fixed)


# grouping subheaders ---------------------------------------------


subheaders <- name_fixed %>%
    filter(across(-name_fixed, is.na)) %>%
    pull(name_fixed) %>%
    unique() %>%
    str_c(collapse = "|")

sub_header_fixed <- name_fixed %>%
    untangle2(regex = subheaders, orig = name_fixed, class) %>%
    select(class, everything()) %>%
    mutate(
        class = if_else(
            if_all(-c(class, info_type), is.na),
            true = NA_character_,
            false = class
        )
    ) # %>%
    # filter(across(-info_type, is.na))



# broken types ----------------------------------------------------



# broken_types_name <- name_fixed %>%
#     filter(across(-info_type, is.na)) %>%
#     pull(info_type) %>%
#     unique() %>%
#     str_c(collapse = "|")
# broken_types_name

type_fixed <- sub_header_fixed %>%
    mutate(
        info_type = if_else(
            if_all(-info_type, is.na),
            true = str_c("--", info_type),
            false = info_type
        )
    ) %>%
    unbreak_vals(
        "^--", # broken_types_name,
        info_type,
        type_fixed,
        sep = ""
    ) %>%
    mutate(type_fixed = str_replace(type_fixed, "-+", " "))



# fill type -----------------------------------------------------

type_completed <- type_fixed %>%
    fill(type_fixed)

type_completed$type_fixed %>% unique() %>% sort()
type_completed$class %>% unique() %>% sort()
type_completed$name_fixed %>% unique() %>% sort()




# typo age --------------------------------------------------------

type_completed$info_age %>% unique() %>% sort()

age_fixed <- type_completed %>%
    mutate(
        info_age = str_replace(info_age, "Castel", "Castle")
    )

age_fixed$info_age %>% unique() %>% sort()



# longer time -----------------------------------------------------

time_fixed <- age_fixed %>%
    pivot_longer(matches("^t[0|1]"),
                 names_to = c("time", ".value"),
                 names_pattern = "t([0|1])_(.*)"
    )



# separate costs --------------------------------------------------


# time_fixed %>%
#     separate(
#         cost,
#         into = c("costo_cibo", "costo_legno", "costo_oro")
#     ) %>%
#     mutate(across(
#         c("costo_cibo", "costo_legno", "costo_oro"),
#         parse_number
#     )) %>%
#     View()

cost_fixed <- time_fixed %>%
    separate(
        cost,
        into = c("costo_cibo", "costo_legno", "costo_oro")
    ) %>%
    mutate(across(
        c(costo_cibo, costo_legno, costo_oro),
        ~ str_replace_all(.x, "(^[FWG])", "0\\1") %>%
            parse_number()
    ))
View(cost_fixed)

zero_values <- cost_fixed %>%
    mutate(
        build_time = str_replace(build_time, "^Non-trainable$", "0"),
        across(everything(), str_replace, "^none$", "0")
    )

# numbers ---------------------------------------------------------

numbers_fixed <- zero_values %>%
    mutate(across(
        build_time:damage,
        ~str_replace_all(.x, ",", ".") %>%
            parse_number()
    ))




# accuracy --------------------------------------------------------

accuracy_fixed <- numbers_fixed %>%
    mutate(accuracy = parse_number(accuracy)/100)
View(accuracy_fixed)



# armor -----------------------------------------------------------


armor_fixed <- accuracy_fixed %>%
    separate(
        col = armor_melee_pierce,
        into = c("armor_melee", "armor_pierce"),
        sep = "/"
    )

View(armor_fixed)



# types -----------------------------------------------------------


final <- armor_fixed %>%
    type_convert()



# res -------------------------------------------------------------

final
glimpse(final)
View(final)
