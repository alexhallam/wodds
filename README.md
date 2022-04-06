
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wodds

<!-- badges: start -->
<!-- badges: end -->

The goal of `wodds` is to make the calculations of whisker odds (wodds)
easy. Whisker odds follow the same rules as letter-values, but with a
different naming system.

## Installation

You can install the development version of `wodds` from
[GitHub](https://github.com) with:

``` r
# install.packages("devtools")
devtools::install_github("alexhallam/wodds")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
options(digits=1)
library(wodds)
library(knitr)
a <- rnorm(n = 1e4, 0, 1)
df_wodds <- wodds::wodds(a)
df_wodds
#> # A tibble: 11 × 3
#>    lower_value wodd_name upper_value
#>          <dbl> <chr>           <dbl>
#>  1     0.00623 M             0.00623
#>  2    -0.665   F             0.678  
#>  3    -1.13    E             1.15   
#>  4    -1.50    S             1.52   
#>  5    -1.85    SM            1.86   
#>  6    -2.13    SF            2.15   
#>  7    -2.37    SE            2.45   
#>  8    -2.59    S2            2.64   
#>  9    -2.79    S2M           2.83   
#> 10    -2.97    S2F           3.01   
#> 11    -3.06    S2E           3.06
```

Works with `knitr::kable` for publications.

``` r
knitr::kable(df_wodds, align = 'c',digits = 3)
```

| lower\_value | wodd\_name | upper\_value |
|:------------:|:----------:|:------------:|
|    0.006     |     M      |    0.006     |
|    -0.665    |     F      |    0.678     |
|    -1.133    |     E      |    1.152     |
|    -1.504    |     S      |    1.517     |
|    -1.848    |     SM     |    1.858     |
|    -2.130    |     SF     |    2.146     |
|    -2.375    |     SE     |    2.451     |
|    -2.591    |     S2     |    2.641     |
|    -2.788    |    S2M     |    2.833     |
|    -2.974    |    S2F     |    3.008     |
|    -3.061    |    S2E     |    3.062     |
