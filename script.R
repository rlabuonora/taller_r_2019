pcp_data <- function(df) {
  is_numeric <- vapply(df, is.numeric, logical(1))
  
  # sapply(df, is.numeric)
  # lapply(df, is.numeric)
  
  rescale_01 <- function(x) {
    rng <- range(x, na.rm = TRUE)
    (x-rng[1]) / (rng[2] - rng[1])
  }
  
  df[is_numeric] <- lapply(df[is_numeric], rescale_01)
  
  df$.row <- rownames(df)
  
  tidyr::gather_(df, "variable", "value", names(df)[is_numeric])

}

# 
pcp <- function(df, ...) {
  df <- pcp_data(df)
  ggplot(df, aes(variable, value, group=.row)) + geom_line(...)
}

pcp(mpg)
pcp(mpg, aes(colour = drv))

# rescal_01 en el global env
rescale_01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x-rng[1]) / (rng[2] - rng[1])
}


df_scaled <- mutate_if(mpg, is.numeric, rescale_01)

tidyr::gather_(df_scaled, "variable", "value", names(purrr::keep(mpg, is.numeric))) %>% 
  arrange(.row)
