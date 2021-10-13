
# Pacchetti utilizzati --------------------------------------------

library(here)
library(tidyverse)



# mash -----------------------------------------------------------


# Importare i seguenti due file correttamente


test <- here("data-raw/test.xlsx")


test2 <- here("data-raw/test2.xlsx")




# unbreak ---------------------------------------------------------

# sistema le seguenti tabelle

tribble(
    ~A,     ~B,
    "good", 1,
    "bad",  2,
    "very", 3,
    "bad",  NA
)


tribble(
    ~ID,     ~Peso, ~Altezza,
    1,       "70",    "170",
    NA,      "kg",    "cm",
    2,       "80",    "180",
    NA,      "kg",    "cm"
)


tribble(
    ~ID,     ~Peso, ~Altezza,
    "1a",       "70",    "170",
    "(Judy)",      NA,    NA,
    "b2",       "80",    "180",
    "(Mark)",      NA,    NA,
    "3c (jade)",       "90",    "190",
)



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
)
