
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
set.seed(42)
a <- rnorm(n = 1e4, 0, 1)
df_wodds <- wodds::wodds(a)
df_wodds
#> # A tibble: 11 × 3
#>    lower_value wodd_name upper_value
#>          <dbl> <chr>           <dbl>
#>  1     -0.0152 M             -0.0152
#>  2     -0.694  F              0.663 
#>  3     -1.17   E              1.16  
#>  4     -1.57   S              1.52  
#>  5     -1.88   SM             1.87  
#>  6     -2.17   SF             2.15  
#>  7     -2.41   SE             2.41  
#>  8     -2.66   S2             2.64  
#>  9     -2.86   S2M            2.88  
#> 10     -3.01   S2F            3.22  
#> 11     -3.13   S2E            3.34
```

``` r
df_wodds_and_outs <- wodds::wodds(a, include_outliers = TRUE)
df_wodds_and_outs
#> # A tibble: 17 × 3
#>    lower_value wodd_name upper_value
#>          <dbl> <chr>           <dbl>
#>  1     -0.0152 M             -0.0152
#>  2     -0.694  F              0.663 
#>  3     -1.17   E              1.16  
#>  4     -1.57   S              1.52  
#>  5     -1.88   SM             1.87  
#>  6     -2.17   SF             2.15  
#>  7     -2.41   SE             2.41  
#>  8     -2.66   S2             2.64  
#>  9     -2.86   S2M            2.88  
#> 10     -3.01   S2F            3.22  
#> 11     -3.13   S2E            3.34  
#> 12     -3.14   *1*            3.34  
#> 13     -3.18   *2*            3.47  
#> 14     -3.20   *3*            3.50  
#> 15     -3.33   *4*            3.58  
#> 16     -3.37   *5*            4.33  
#> 17     -4.04   *6*           NA
```

A `knitr::kable` example for publication.

``` r
knitr::kable(df_wodds, align = 'c',digits = 3)
```

| lower\_value | wodd\_name | upper\_value |
|:------------:|:----------:|:------------:|
|    -0.01     |     M      |    -0.01     |
|    -0.69     |     F      |     0.66     |
|    -1.17     |     E      |     1.16     |
|    -1.57     |     S      |     1.52     |
|    -1.88     |     SM     |     1.87     |
|    -2.17     |     SF     |     2.15     |
|    -2.42     |     SE     |     2.41     |
|    -2.66     |     S2     |     2.64     |
|    -2.86     |    S2M     |     2.88     |
|    -3.01     |    S2F     |     3.22     |
|    -3.13     |    S2E     |     3.34     |

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
