# Data
Mar 24, 2025

All data needed for the analyses:

- sub.mod.data.3.ba : sous-jeu de données, avec 30% des data, incluant
  des placettes pour lesquelles la BA n’est pas connue (donc le modèle
  “complet” ne peut pas être fitté avec ces données)

- sub.mod.data.3 : mais sans placettes avec BA inconnu

- sub.mod.data.1 : idem avec 10% des données

- mod.data: toutes les données sauf les placettes sans BA

- mod.data.all : toutes les données

``` r
fs::dir_tree()
```

    .
    ├── README.md
    ├── README.qmd
    ├── README.rmarkdown
    ├── mod.data
    ├── mod.data.all
    ├── sub.mod.data.1
    ├── sub.mod.data.3
    └── sub.mod.data.3.ba
