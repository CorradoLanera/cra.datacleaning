
# Pacchetti utilizzati --------------------------------------------

library(here)
library(tidyverse)
library(readxl)

df <- here("data-raw/aoe_tidy.xlsx") |>
    read_xlsx()

df_0 <- df |>
    select(type_fixed, class, name_fixed, info_age, t0_cost)


# funzione utile --------------------------------------------------

show_in_excel <- function(.data) {
    if (interactive()) {
        tmp <- tempfile(fileext = ".csv")
        readr::write_excel_csv(.data, tmp)

        fs::file_show(tmp)
    }

    invisible(.data)  # so that we can continuing piping
}




# completamento ---------------------------------------------------
# Completa il campo `type_fixed` del dataframe semplificato `df_0`


df_0 |>
    fill(type_fixed)



# separazione -----------------------------------------------------
# Separa correttamente il campo relativo al costo di produzione (`cost`)
#  del dataframe semplificato `df_0`.


df_0 |>
    separate(
        t0_cost,
        into = c("costo_cibo", "costo_legno", "costo_oro")
    ) |>
    show_in_excel()


df_0 |>
    separate(
        t0_cost,
        into = c("costo_cibo", "costo_legno", "costo_oro")
    ) |>
    mutate(
        costo_cibo = str_replace(costo_cibo, "^F", "0F"),
        costo_legno = str_replace(costo_legno, "^W", "0W"),
        costo_oro = str_replace(costo_oro, "^G", "0G"),
    ) |>
    show_in_excel()







# longer ----------------------------------------------------------
# trasportare i tempi nelle loro proprie variabili per il dataset
# completo `df`.


time_fixed <- df %>%
    pivot_longer(matches("^t[0|1]"),
                 names_to = c("time", ".value"),
                 names_pattern = "t([0|1])_(.*)"
    ) |>
    show_in_excel()

