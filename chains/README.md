# Chains
Mar 24, 2025

All Bayesian chains in csv structured in “**/model/chain_number.csv**”.
cmdstanr number the chains with “**model-date-chain-sha.csv**”.

``` r
fs::dir_tree()
```

    .
    ├── README.md
    ├── README.qmd
    ├── README.rmarkdown
    ├── nul
    │   ├── nul-202503241224-1-93739a.csv
    │   ├── nul-202503241224-2-93739a.csv
    │   ├── nul-202503241224-3-93739a.csv
    │   └── nul-202503241224-4-93739a.csv
    ├── origin
    │   ├── factor_cov-202503241313-1-0b2c06.csv
    │   ├── factor_cov-202503241313-2-0b2c06.csv
    │   ├── factor_cov-202503241313-3-0b2c06.csv
    │   └── factor_cov-202503241313-4-0b2c06.csv
    ├── system
    │   ├── factor-202503241317-1-0ea700.csv
    │   ├── factor-202503241317-2-0ea700.csv
    │   ├── factor-202503241317-3-0ea700.csv
    │   └── factor-202503241317-4-0ea700.csv
    └── systemorigin
        ├── factor-202503241231-1-0f910e.csv
        ├── factor-202503241231-2-0f910e.csv
        ├── factor-202503241231-3-0f910e.csv
        └── factor-202503241231-4-0f910e.csv
