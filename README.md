
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
#>  1    -0.00209 M            -0.00209
#>  2    -0.659   F             0.655  
#>  3    -1.15    E             1.14   
#>  4    -1.54    S             1.51   
#>  5    -1.89    SM            1.80   
#>  6    -2.20    SF            2.12   
#>  7    -2.48    SE            2.39   
#>  8    -2.68    S2            2.67   
#>  9    -2.94    S2M           2.92   
#> 10    -3.14    S2F           3.12   
#> 11    -3.48    S2E           3.28
```

``` r
df_wodds_and_outs <- wodds::wodds(a, include_outliers = TRUE)
df_wodds_and_outs
#> # A tibble: 17 × 3
#>    lower_value wodd_name upper_value
#>          <dbl> <chr>           <dbl>
#>  1    -0.00209 M            -0.00209
#>  2    -0.659   F             0.655  
#>  3    -1.15    E             1.14   
#>  4    -1.54    S             1.51   
#>  5    -1.89    SM            1.80   
#>  6    -2.20    SF            2.12   
#>  7    -2.48    SE            2.39   
#>  8    -2.68    S2            2.67   
#>  9    -2.94    S2M           2.92   
#> 10    -3.14    S2F           3.12   
#> 11    -3.48    S2E           3.28   
#> 12    -3.54    *1*           3.30   
#> 13    -3.71    *2*           3.35   
#> 14    -3.80    *3*           3.36   
#> 15    -3.86    *4*           3.51   
#> 16    -3.97    *5*           4.48   
#> 17    -4.05    *6*          NA
```

A `knitr::kable` example for publication.

``` r
knitr::kable(df_wodds, align = 'c',digits = 3)
```

| lower\_value | wodd\_name | upper\_value |
|:------------:|:----------:|:------------:|
|    -0.002    |     M      |    -0.002    |
|    -0.659    |     F      |    0.655     |
|    -1.154    |     E      |    1.138     |
|    -1.537    |     S      |    1.514     |
|    -1.892    |     SM     |    1.797     |
|    -2.199    |     SF     |    2.121     |
|    -2.484    |     SE     |    2.395     |
|    -2.677    |     S2     |    2.669     |
|    -2.935    |    S2M     |    2.916     |
|    -3.141    |    S2F     |    3.117     |
|    -3.477    |    S2E     |    3.278     |

## Whisker Odds and Letter-Values

Letter-Values are a fantiastic tool! I think the naming could be
improved. For this reason I introduce whisker odds (wodds) as an
alternative naming system. My hypothesis is that with an alternative
naming system the use of these descriptive statistics will be see more
use. This is a rebranding of a what I think is a powerfull modern
statistical tool.

![](man/figures/table.png)
