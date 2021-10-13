library(unheadr)
library(tidyverse)


tribble(
    ~,       ~"Peso", ~"Altezza",
    "ID",     "(KG)", "(KG)",
    "1",       "70",    "170",
    "2",       "80",    "180",
) |>
    mash_colnames(1)


tribble(
    ~A,     ~B,
     "good", 1,
     "bad",  2,
     "very", 3,
     "bad",  NA
) |>
    # unheadr::unbreak_vals("bad", A, newA) # scontato che il resto della riga sia NA
    unheadr::unbreak_rows("very", A)


tribble(
    ~ID,     ~Peso, ~Altezza,
     1,       "70",    "170",
     NA,      "kg",    "cm",
     2,       "80",    "180",
     NA,      "kg",    "cm"
) |>
    # unheadr::unbreak_vals("^[a-z]", Peso, newP)
    unheadr::unbreak_rows("^\\d", Peso)
    # unheadr::unbreak_rows("^[a-z]", Peso)


tribble(
    ~ID,     ~Peso, ~Altezza,
    "1a",       "70",    "170",
    "(Judy)",      NA,    NA,
    "b2",       "80",    "180",
    "(Mark)",      NA,    NA,
    "3c (jade)",       "90",    "190",
) |>
    unheadr::unbreak_vals("^\\(", ID, id_name)
    # unheadr::unbreak_rows("^\\w", ID)
    # unheadr::unbreak_vals("^\\w", ID, id_name)
    # unheadr::unbreak_vals("^[a-z]", ID, id_name)



tribble(
    ~ID,     ~Peso, ~Altezza,
    "Placebo",       NA,    NA,
    "1",       "60",    "160",
    "2",       "70",    "170",
    "Trattamento",       NA,    NA,
    "1",       "80",    "180",
    "2",       "90",    "190"
) |>
    unheadr::untangle2("^\\D", ID, "Arm")
    # unheadr::unbreak_vals("Placebo|Trattamento", ID, Arm)
    # unheadr::unbreak_rows("Placebo|Trattamento", ID, "Arm")


tribble(
    ~ID,     ~Peso, ~Altezza,  ~Arm, ~Armid,
    "1",       "60",    "160", "Placebo",1,
    "2",       "70",    "170", NA,1,
    "3",       "80",    "180", NA,1,
    "1",       "90",    "190", "Trattamento",2,
    "2",       "100",    "200", NA,2,
    "3",       "110",    "210", NA,2
) |>
    # tidyr::fill(Arm)
    # tidyr::replace_na(Arm, lead(Arm))
    # mutate(Arm = replace_na(Arm, lead(Arm)))
    with_groups(Armid, mutate, Arm = Arm[[1]])




tribble(
    ~A,    ~B, ~N, ~M,
    "a, d", "b", 1.2, "1,22",
    "a, d", "b", 1.2, "12.2"
) |>
    # mutate(across(everything(), str_replace_all, ",", "."))
    # mutate(across(everything(), parse_number))
    # mutate(across(where(is_character), parse_number))
    mutate(across(where(is_character), str_replace_all, "(\\d+),(\\d+)", "\\1.\\2"))



tribble(
    ~A,    ~B, ~N, ~M,
    "a, d", "b", "12.3%", "1,22",
    "a, d", "b", "12%", "1,22"
) |>
    # mutate(N = str_remove(N, "%"))
    # mutate(N = parse_number(N))
    mutate(N = str_replace(N, "[^\\d.]", ""))
    mutate(N = str_replace(N, "(\\d+(\\.\\d+)?).*", "\\1"))




tribble(
    ~id, ~peso_1, ~peso_2, ~peso_3,
     1, 60, 65, 70,
     2, 70, 65, 60) |>
    # pivot_longer(-id, names_to = "time", values_to = "peso")
    # pivot_longer(-id, "time", "peso")
    # pivot_wider(-id, "time", "peso")
    separate(-id, c("peso", "time"))


tribble(
    ~id, ~peso,
    1, "6 kg",
    2, "700 g") |>
    # separate(peso, c("peso", "peso_unit"))
    # separate(peso, "peso", "peso_unit")
    # pivot_wider(id, values_from = "peso", names_from = "peso_unit")
    pivot_longer(-id, values_to = "peso", names_to = "peso_unit")
