
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


df_0



# separazione -----------------------------------------------------
# Separa correttamente il campo relativo al costo di produzione (`cost`)
#  del dataframe semplificato `df_0`.


df_0




# longer ----------------------------------------------------------
# trasportare i tempi nelle loro proprie variabili per il dataset
# completo `df`.


