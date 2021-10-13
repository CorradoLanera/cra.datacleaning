
# Pacchetti utilizzati --------------------------------------------

library(here)



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


db_raw <- here("data-raw/messy_aoe.xlsx")
