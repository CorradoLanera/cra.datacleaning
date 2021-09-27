
# for students/users ----------------------------------------------


install.packages(c(
    "here", "janitor", "tidyverse", "unheadr", "usethis"
))




# for teachers/developers (+ students/users) ----------------------


install.packages("renv")
renv::install(c(
    # CRAN
    "distill", "fontawesome", "knitr", "metathis", "rmarkdown",
    "xaringan", "writexl",

    # GitHub
    "gadenbuie/countdown", "gadenbuie/xaringanExtra",
    "gadenbuie/xaringanthemer",
    "hadley/emo"
))
