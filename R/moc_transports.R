#' Plot the moc_transports data set
#' 
#' @export
#' @param x moc_transports data frame (class of "rapid_moc_transports")
#' @param y ignored
#' @param smooth logical, if TRUE add a smoothing line (for timeseries only)
#' @param by chr, one of 'none' (default timeseries), 'month' (ghost plot by month over the years)
#'  or 'year' a box plot by year
#' @param ... ignored
#' @return ggplot2 object
plot.rapid_moc_transports = function(x = read_moc_transports(), y,
                                     smooth = TRUE, 
                                     by = c("none", "month", "year")[1],
                                     ...){
  lutable = attr(x, "longnames")
  lut = lutable$longname
  names(lut) = lutable$name
  # transform from wide to long
  x = tidyr::pivot_longer(x,
                          !dplyr::any_of("date"),
                          names_to = "name",
                          values_to = "value") |>
    dplyr::mutate(name = factor(lut[.data$name], levels = lutable$longname))
  
  gg = ggplot2::ggplot(data = x, 
                       mapping = ggplot2::aes(x = date, y = value)) +
    ggplot2::geom_line()
  if (smooth) gg = gg + ggplot2::geom_smooth(method = 'loess', formula = 'y ~ x')
  
  gg + ggplot2::facet_wrap(~name, scales = "free_y", ncol = 2)
  
}