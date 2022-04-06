#' Wodd format
#'
#' @description
#' private function for internal package use. cleans up names
#'
#' @param wodd_name - a string
#'
#' @return a vector string of names
wodd_format <- function(wodd_name){
  wodd_name = gsub("S0", "", wodd_name)
  wodd_name = gsub("S1", "S", wodd_name)
  wodd_name
}

#' Raw wodd
#'
#' @description
#' private function for internal package use. Calculates raw wodd name without formatting.
#'
#' @param index - an int
#'
#' @return a vector string of names
raw_wodd <- function(index){
  int = 2^index
  S = 0
  counted = FALSE
  if (int >= 16){
    while (counted == FALSE){
      if (int >= 16^S){S = S+1}
      else{counted = TRUE; S = S - 1}
    }
  }
  if ((16^(S)*1) == int){return(wodd_format(glue::glue('S{S}')))
    }else if ((16^(S)*2) == int){return(wodd_format(glue::glue('S{S}M')))
    }else if ((16^(S)*4) == int){return(wodd_format(glue::glue('S{S}F')))
    }else if ((16^(S)*8) == int){return(wodd_format(glue::glue('S{S}E')))}
}

#' Make wodd name big data
#'
#' @description
#' private function for internal package use. If the data exceeds depth of 100 then calculate wodds manually
#'
#' @param index - an int
#'
#' @return a vector string of names
make_wodd_name_big_data <- function(index){
  wodd_depth <- seq(1:index)
  wodd_name <- map_chr(.x = wodd_depth, .f = raw_wodd)
  wodd_name
}

#' Make wodd name big data
#'
#' @description
#' private function for internal package use. This is the standard way that wodds are obtained. "Dictionary"
#'
#' @param index - an int
#'
#' @return a vector string of names
select_wodd_name_from_table <- function(index){
  if (index > 100){
    stop("Please set big_data = TRUE")
  }else{
  first_100_wodd_depths_and_names <- structure(list(i = 1:100, wodd_name = c("M", "F", "E", "S", "SM",
                                    "SF", "SE", "S2", "S2M", "S2F", "S2E", "S3", "S3M", "S3F", "S3E",
                                    "S4", "S4M", "S4F", "S4E", "S5", "S5M", "S5F", "S5E", "S6", "S6M",
                                    "S6F", "S6E", "S7", "S7M", "S7F", "S7E", "S8", "S8M", "S8F",
                                    "S8E", "S9", "S9M", "S9F", "S9E", "S0", "S0M", "S0F", "S0E",
                                    "S1", "S1M", "S1F", "S1E", "S2", "S2M", "S2F", "S2E", "S3", "S3M",
                                    "S3F", "S3E", "S4", "S4M", "S4F", "S4E", "S5", "S5M", "S5F",
                                    "S5E", "S6", "S6M", "S6F", "S6E", "S7", "S7M", "S7F", "S7E",
                                    "S8", "S8M", "S8F", "S8E", "S9", "S9M", "S9F", "S9E", "S20",
                                    "S20M", "S20F", "S20E", "S21", "S21M", "S21F", "S21E", "S22",
                                    "S22M", "S22F", "S22E", "S23", "S23M", "S23F", "S23E", "S24",
                                    "S24M", "S24F", "S24E", "S25")), class = c("tbl_df", "tbl", "data.frame"
                                    ), row.names = c(NA, -100L))
  wodd_name <- dplyr::filter(first_100_wodd_depths_and_names, i <= index) %>% dplyr::pull(wodd_name)
  wodd_name
  }
}
#' Calculate whisker odds
#'
#' @description makes whisker odds
#'
#' @param y A vector of values
#' @param include_tail_area a binary. If true then include a column of tail area 2^(i)
#' @param include_outliers a binary. If true include a column of outliers beyond the last wodd depth
#' @param include_depth a binary. If true include a column indicating the depth of the letter value
#'
#' @return A dataframe of wodds
#'   \item{lower_value}{lower value}
#'   \item{wodd_name}{Name of wodd}
#'   \item{upper_value}{upper value}
#'
#' @import dplyr
#' @importFrom tibble tibble
#' @importFrom magrittr %>%
#' @importFrom purrr map_chr
#' @importFrom stats qnorm
#'
#' @export
#'
#' @examples
#'
#' @examples
#' wodds(rnorm(1e4, 0, 1))
wodds <- function(y, include_tail_area = FALSE, include_outliers = FALSE, include_depth= FALSE, big_data = FALSE){
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
  if (big_data == TRUE){
    wodd_depth_name <- make_wodd_name_big_data(k)
  }else{
    wodd_depth_name <- select_wodd_name_from_table(k)
  }
  o_upper <- sort(y[y>max(upper)])
  o_lower <- sort(y[y<min(lower)], decreasing = TRUE)
  o_max_len <- max(length(o_upper), length(o_lower))
  length(o_upper) <- o_max_len
  length(o_lower) <- o_max_len
  length(depth) <- o_max_len + length(depth)
  length(tail_area) <- o_max_len + length(tail_area)
  o_name <- paste0("*", seq(1,o_max_len), "*")
  df_o <- tibble::tibble(lower_value=o_lower, wodd_name = o_name, upper_value=o_upper)
  df_base <- tibble::tibble(lower_value=lower, wodd_name = wodd_depth_name, upper_value=upper)
  df_with_outliers <- dplyr::bind_rows(df_base, df_o)
  df_with_outliers_depth <- df_with_outliers %>% dplyr::mutate(depth = depth) %>% dplyr::select(depth, lower_value, wodd_name, upper_value)
  df_with_outliers_depth_tail_area <- df_with_outliers %>% dplyr::mutate(depth = depth, tail_area = tail_area) %>% dplyr::select(depth, tail_area, lower_value, wodd_name, upper_value)
  if(include_outliers == TRUE){
    if(include_tail_area ==FALSE & include_depth == FALSE){
      df_with_outliers_depth_tail_area %>% dplyr::select(-tail_area, -depth)
    }else if(include_tail_area ==TRUE &  include_depth == FALSE){
      df_with_outliers_depth_tail_area %>% dplyr::select(-depth)
    }else if(include_tail_area ==TRUE & include_depth == TRUE){
      df_with_outliers_depth_tail_area
    }
  }else{
    df_with_depth_tail_area <- df_with_outliers_depth_tail_area %>% dplyr::filter(!is.na(depth))
    if(include_tail_area ==FALSE & include_depth == FALSE){
      df_with_depth_tail_area %>% dplyr::select(-tail_area, -depth)
    }else if(include_tail_area ==TRUE &  include_depth == FALSE){
      df_with_depth_tail_area %>% dplyr::select(-depth)
    }else if(include_tail_area ==TRUE & include_depth == TRUE){
      df_with_depth_tail_area
    }
  }
}
