
# Pacchetti utilizzati --------------------------------------------

library(here)
library(tidyverse)
library(readxl)



# mash -----------------------------------------------------------


# Importare i seguenti due file correttamente


test <- here("data-raw/test.xlsx")
test |>
    read_xlsx() |>
    mash_colnames(1)



test2 <- here("data-raw/test2.xlsx")
test2 |>
    read_xlsx(col_names = FALSE) |>
    mash_colnames(2, keep_names = FALSE)




# unbreak ---------------------------------------------------------

# sistema le seguenti tabelle

tribble(
    ~A,     ~B,
    "good", 1,
    "bad",  2,
    "very", 3,
    "bad",  NA
) |>
    unheadr::unbreak_rows("very", A)


tribble(
    ~ID,     ~Peso, ~Altezza,
    1,       "70",    "170",
    NA,      "kg",    "cm",
    2,       "80",    "180",
    NA,      "kg",    "cm"
) |>
    unheadr::unbreak_vals("^[a-z]", Peso, Peso_fixed)


tribble(
    ~ID,     ~Peso, ~Altezza,
    "1a",       "70",    "170",
    "(Judy)",      NA,    NA,
    "b2",       "80",    "180",
    "(Mark)",      NA,    NA,
    "3c (jade)",       "90",    "190",
) |>
    unheadr::unbreak_vals("^\\(", ID, id_name)



# gruppi ----------------------------------------------------------

# Rendi espliciti i gruppi della seguente base di dati
#
#
tribble(
    ~ID,     ~Peso, ~Altezza,
    "Placebo",       NA,    NA,
    "1",       "60",    "160",
    "2",       "70",    "170",
    "Trattamento",       NA,    NA,
    "1",       "80",    "180",
    "2",       "90",    "190"
) |>
    unheadr::untangle2("^[^0-9]", ID, "Braccio")
