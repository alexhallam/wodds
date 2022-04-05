# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

get_first_digit_in_hex <- function(tail_area_odds){
  first_digit_in_hex <- substr(as.character(as.integer(as.character(as.hexmode(tail_area_odds)))), 1, 1)
  first_digit_in_hex
}
get_log10_in_hex <- function(tail_area_odds){
  log10_in_hex <- log10(as.integer(as.character(as.hexmode(tail_area_odds))))
  log10_in_hex
}
wodd_name_key_values <- c(
  '2' = 'M',
  '4' = 'F',
  '8' = 'E',
  '1' = ''
)
make_name <- function(tail_area_odds){
  s <- get_first_digit_in_hex(tail_area_odds)
  l <- get_log10_in_hex(tail_area_odds)
  string <- wodd_name_key_values[s]
  app <- ifelse(l >= log10(100),paste0("S", trunc(l)), ifelse(l < log10(128) & l > log10(8), "S", ""))
  string_vec <- paste0(app,string)
  string_vec
}
wodds <- function(y, include_tail_area = FALSE, include_outliers = TRUE, include_depth= FALSE){
  data = sort(y)
  s = sort(data)
  n = length(data)
  alpha = 0.05
  k = as.integer(floor(log2(n) - log2(2 * (qnorm(1 - (alpha / 2)) ^ 2))) + 1L) # rule 3
  lvl = (k - 1) * 2
  nq = lvl - 1
  qs = rep(0, nq)  # initialize array of quantiles
  f <- function(n){(1 + floor(n)) / 2}
  for (i in 1:k){
    # median calculation
    if (i == 1){d = f(n);qs[i - 1] = 0.5;d}else{d = f(d);d}
    if (ceiling(d) != floor(d)){
        l_idx1 = as.integer(floor(d))
        l_idx2 = as.integer(ceiling(d))
        u_idx1 = as.integer(floor(n - d + 1))
        u_idx2 = as.integer(ceiling(n - d + 1))
        l = mean(c(s[l_idx1], s[l_idx2]))
        u = mean(c(s[u_idx1], s[u_idx2]))
        ql = mean(c(l_idx1 / n, l_idx2 / n))
        qu = mean(c(u_idx1 / n, u_idx2 / n))
    }else{
        l = s[as.integer(d)]
        u = s[as.integer(floor(n - d + 1))]
        ql = as.integer(d) / n
        qu = as.integer(floor(n - d + 1)) / n
  }
  qs[((i - 1) * 2) - 1] = ql
  qs[(i - 1) * 2] = qu
  vf = quantile(data, qs)
  }
  qs <- c(.5, .5, qs)
  vf <- c(median(vf), median(vf), vf)
  qlower = qs[seq(1, length(qs), 2)]
  qupper = qs[seq(2, length(qs), 2)]
  lower = vf[seq(1, length(vf), 2)]
  upper = vf[seq(2, length(vf), 2)]
  depth = seq(1, k)
  tail_area = 2 ^ depth
  wodd_depth_name <- make_name(tail_area)
  o_upper <- sort(y[y>max(upper)])
  o_lower <- sort(y[y<min(lower)], decreasing = TRUE)
  o_max_len <- max(length(o_upper), length(o_lower))
  length(o_upper) <- o_max_len
  length(o_lower) <- o_max_len
  o_name <- paste0("*", seq(1,o_max_len), "*")
  #df_o <- tibble::tibble(lower_value=o_lower, wodd_name = o_name, upper_value=o_upper)
  #df_base <- tibble::tibble(lower_value=lower, wodd_name = wodd_depth_name, upper_value=upper)
  if (include_tail_area == TRUE & include_outliers == TRUE & include_depth == TRUE){
    #111
    length(tail_area) <- o_max_len
    length(depth) <- o_max_len
    df_o <- tibble::tibble(lower_value=o_lower, wodd_name = o_name, upper_value=o_upper)
    df_base <- tibble::tibble(include_depth = depth, lower_value=lower, wodd_name = wodd_depth_name, upper_value=upper)
    df <- dplyr::bind_rows(df_base, df_o) %>% dplyr::mutate(tail_area = tail_area, include_depth = depth)
    df
  }else if (include_tail_area == FALSE & include_outliers == TRUE & include_depth == TRUE){
    #011
    length(tail_area) <- o_max_len
    length(depth) <- o_max_len
    df_o <- tibble::tibble(lower_value=o_lower, wodd_name = o_name, upper_value=o_upper)
    df_base <- tibble::tibble(lower_value=lower, wodd_name = wodd_depth_name, upper_value=upper)
    df <- dplyr::bind_rows(df_base, df_o) %>%  dplyr::mutate(include_depth = depth)
    df
  }else if (include_tail_area == TRUE & include_outliers == TRUE & include_depth == FALSE){
    #110
    length(tail_area) <- o_max_len
    length(depth) <- o_max_len
    df_o <- tibble::tibble(lower_value=o_lower, wodd_name = o_name, upper_value=o_upper)
    df_base <- tibble::tibble(lower_value=lower, wodd_name = wodd_depth_name, upper_value=upper)
    df <- dplyr::bind_rows(df_base, df_o) %>%  dplyr::mutate(tail_area = tail_area)
    df
  }else if (include_tail_area == FALSE & include_outliers == TRUE & include_depth == FALSE){
    #010
    length(tail_area) <- o_max_len
    length(depth) <- o_max_len
    df_o <- tibble::tibble(lower_value=o_lower, wodd_name = o_name, upper_value=o_upper)
    df_base <- tibble::tibble(include_depth = depth, tail_area = tail_area, lower_value=lower, wodd_name = wodd_depth_name, upper_value=upper)
    df <- dplyr::bind_rows(df_base, df_o)
    df
  }else if (include_tail_area == TRUE & include_outliers == FALSE & include_depth == TRUE){
    #101
    df_base <- tibble::tibble(include_depth = depth, tail_area = tail_area, lower_value=lower, wodd_name = wodd_depth_name, upper_value=upper)
    df_base
  }else if (include_tail_area == FALSE & include_outliers == FALSE & include_depth == TRUE){
  #001
  df_base <- tibble::tibble(include_depth = depth, lower_value=lower, wodd_name = wodd_depth_name, upper_value=upper)
  df_base
  }else if (include_tail_area == FALSE & include_outliers == FALSE & include_depth == FALSE){
  #000
  df_base <- tibble::tibble(lower_value=lower, wodd_name = wodd_depth_name, upper_value=upper)
  df_base
  }else if (include_tail_area == TRUE & include_outliers == FALSE & include_depth == FALSE){
  #100
  df_base <- tibble::tibble(tail_area = tail_area,lower_value=lower, wodd_name = wodd_depth_name, upper_value=upper)
  df_base
  }
else{
  df_o <- tibble::tibble(lower_value=o_lower, wodd_name = o_name, upper_value=o_upper)
  df_base <- tibble::tibble(lower_value=lower, wodd_name = wodd_depth_name, upper_value=upper)
  df <- dplyr::bind_rows(df_base, df_o)
  df
  }
}


norms <- rnorm(n=500,0,1); wodds(norms, include_tail_area = T) %>% print(n = 30)
pois <- rpois(n=2e5,1); wodds(pois) %>% print(n = 30)
unif <- runif(n=2e5,1,10); wodds(unif) %>% print(n = 30)
td <- rt(n=2e5,10,df = 2); wodds(td) %>% print(n = 30)
