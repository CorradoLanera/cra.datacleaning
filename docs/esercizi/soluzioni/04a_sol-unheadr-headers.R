
# Pacchetti utilizzati --------------------------------------------

library(here)
library(tidyverse)
library(readxl)
library(janitor)
library(unheadr)

# Importazione ----------------------------------------------------


# Importare il file `messy_aoe.xlsx` che si trova dentro la cartella
# `data-raw/` presente dentro la cartella principale del progetto
# (di cui, per esempio, non conosciamo il nome).
#
# - codificare tutti i caratteri rappresentanti un dato mancante come
#   NA
# - rimuovere tutte le righe o colonne vuote
#
#
# - Ripristinare nomi delle variabili a aprtire da quelli spezzati su
#   più righe, includere i raggruppamenti nel nome stesso di ciascuna
#   variabile.
#
# - convertire tutti i nomi di variabile utilizzando la convenzione
#   "snake_case".
#
# - verificare la consistenza dei nomi, ed eventualmente correggere
#   eventuali errori residui


db_raw <- here("data-raw/messy_aoe.xlsx") |>
    read_excel(col_names = FALSE, na = c("", " ", "-")) |>
    remove_empty()

View(db_raw)

db_headers <- db_raw |>
    mash_colnames(4, keep_names = FALSE, sliding_headers = TRUE) |>
    clean_names()

names(db_headers) <- names(db_headers) |>
    str_replace("t1_line_of_sigth", "t1_line_of_sight")

View(db_headers)
