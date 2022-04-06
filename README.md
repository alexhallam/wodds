
<!-- README.md is generated from README.Rmd. Please edit that file -->
<h1 align="center">
Whisker Odds (wodds)
</h1>
<p align="center">
wodds calculation for big data
</p>
<!-- badges: start -->
<!-- badges: end -->

The goal of `wodds` is to make the calculations of whisker odds (wodds)
easy. Wodds follow the same rules as letter-values, but with a different
naming system.

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
#>  1    -0.00501 M            -0.00501
#>  2    -0.670   F             0.660  
#>  3    -1.16    E             1.14   
#>  4    -1.53    S             1.54   
#>  5    -1.86    SM            1.85   
#>  6    -2.12    SF            2.15   
#>  7    -2.47    SE            2.40   
#>  8    -2.68    S2            2.53   
#>  9    -2.83    S2M           2.73   
#> 10    -3.03    S2F           2.88   
#> 11    -3.10    S2E           3.11
```

``` r
df_wodds_and_outs <- wodds::wodds(a, include_outliers = TRUE)
df_wodds_and_outs
#> # A tibble: 17 × 3
#>    lower_value wodd_name upper_value
#>          <dbl> <chr>           <dbl>
#>  1    -0.00501 M            -0.00501
#>  2    -0.670   F             0.660  
#>  3    -1.16    E             1.14   
#>  4    -1.53    S             1.54   
#>  5    -1.86    SM            1.85   
#>  6    -2.12    SF            2.15   
#>  7    -2.47    SE            2.40   
#>  8    -2.68    S2            2.53   
#>  9    -2.83    S2M           2.73   
#> 10    -3.03    S2F           2.88   
#> 11    -3.10    S2E           3.11   
#> 12    -3.10    *1*           3.13   
#> 13    -3.16    *2*           3.15   
#> 14    -3.19    *3*           3.27   
#> 15    -3.57    *4*           3.55   
#> 16    -3.62    *5*           3.70   
#> 17    -3.99    *6*          NA
```

A `knitr::kable` example for publication.

``` r
knitr::kable(df_wodds, align = 'c',digits = 3)
```

| lower\_value | wodd\_name | upper\_value |
|:------------:|:----------:|:------------:|
|    -0.005    |     M      |    -0.005    |
|    -0.670    |     F      |    0.660     |
|    -1.155    |     E      |    1.144     |
|    -1.527    |     S      |    1.540     |
|    -1.857    |     SM     |    1.848     |
|    -2.120    |     SF     |    2.152     |
|    -2.468    |     SE     |    2.398     |
|    -2.682    |     S2     |    2.535     |
|    -2.829    |    S2M     |    2.726     |
|    -3.028    |    S2F     |    2.876     |
|    -3.103    |    S2E     |    3.110     |

## Whisker Odds and Letter-Values

Letter-Values are a fantiastic tool! I think the naming could be
improved. For this reason I introduce whisker odds (wodds) as an
alternative naming system. My hypothesis is that with an alternative
naming system the use of these descriptive statistics will be see more
use. This is a rebranding of a what I think is a powerfull modern
statistical tool.

![](man/figures/table.png)
