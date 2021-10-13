
# Pacchetti utilizzati --------------------------------------------

library(here)
library(tidyverse)
library(readxl)
library(janitor)



# Importazione ----------------------------------------------------


# Importare il file `messy_aoe.xlsx` che si trova dentro la cartella
# `data-raw/` presente dentro la cartella principale del progetto
# (di cui, per esempio, non conosciamo il nome).
#
# - codificare tutti i caratteri rappresentanti un dato mancante come
#   NA
# - rimuovere tutte le righe o colonne vuote
# - convertire tutti i nomi di variabile utilizzando la convenzione
#   "snake_case".


db_raw <- here("data-raw/messy_aoe.xlsx") %>%
    read_excel(na = c("", " ", "-")) %>%
    remove_empty() %>%
    clean_names()
