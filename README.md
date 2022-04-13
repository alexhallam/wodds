
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
#>  1      0.0122 M              0.0122
#>  2     -0.658  F              0.682 
#>  3     -1.11   E              1.16  
#>  4     -1.49   S              1.55  
#>  5     -1.83   SM             1.86  
#>  6     -2.09   SF             2.14  
#>  7     -2.34   SE             2.43  
#>  8     -2.64   S2             2.64  
#>  9     -2.75   S2M            2.85  
#> 10     -3.02   S2F            3.01  
#> 11     -3.36   S2E            3.21
```

``` r
df_wodds_and_outs <- wodds::wodds(a, include_outliers = TRUE)
df_wodds_and_outs
#> # A tibble: 17 × 3
#>    lower_value wodd_name upper_value
#>          <dbl> <chr>           <dbl>
#>  1      0.0122 M              0.0122
#>  2     -0.658  F              0.682 
#>  3     -1.11   E              1.16  
#>  4     -1.49   S              1.55  
#>  5     -1.83   SM             1.86  
#>  6     -2.09   SF             2.14  
#>  7     -2.34   SE             2.43  
#>  8     -2.64   S2             2.64  
#>  9     -2.75   S2M            2.85  
#> 10     -3.02   S2F            3.01  
#> 11     -3.36   S2E            3.21  
#> 12     -3.38   *1*            3.21  
#> 13     -3.47   *2*            3.23  
#> 14     -3.48   *3*            3.26  
#> 15     -3.52   *4*            3.55  
#> 16     -3.56   *5*            4.43  
#> 17     -4.11   *6*           NA
```

A `knitr::kable` example for publication.

``` r
knitr::kable(df_wodds, align = 'c',digits = 3)
```

| lower\_value | wodd\_name | upper\_value |
|:------------:|:----------:|:------------:|
|     0.01     |     M      |     0.01     |
|    -0.66     |     F      |     0.68     |
|    -1.11     |     E      |     1.16     |
|    -1.49     |     S      |     1.55     |
|    -1.83     |     SM     |     1.86     |
|    -2.09     |     SF     |     2.14     |
|    -2.34     |     SE     |     2.43     |
|    -2.64     |     S2     |     2.64     |
|    -2.75     |    S2M     |     2.85     |
|    -3.02     |    S2F     |     3.01     |
|    -3.36     |    S2E     |     3.21     |

### Getting the depth

``` r
wodds::get_depth_from_n(n=15734L, alpha = 0.05)
#> [1] 11
```

### Getting the sample size

``` r
wodds::get_n_from_depth(d = 11L)
#> [1] 15734
```

## Whisker Odds and Letter-Values

Letter-Values are a fantiastic tool! I think the naming could be
improved. For this reason I introduce whisker odds (wodds) as an
alternative naming system. My hypothesis is that with an alternative
naming system the use of these descriptive statistics will be see more
use. This is a rebranding of a what I think is a powerfull modern
statistical tool.

![](man/figures/table.png)
