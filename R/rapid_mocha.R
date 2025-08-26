#' Plot RAPID-MOCHA data time series
#' 
#' @export
#' @param x the mocha table
#' @param y ignored
#' @param smooth logical, if TRUE add a smoothing line (for timeseries only)
#' @param by chr, one of 'none' (default timeseries), 'day' (ghost plot by day over the years)
#'  or 'year' a box plot by year
#' @param ... ignored
#' @return a ggplot2 object
plot.rapid_mocha_time = function(x = read_rapid_mocha(), y,
                            smooth = TRUE, 
                            by = c("none", "day", "year"), 
                            ...){
  by = tolower(by[1])
  
  if (by == "day"){
    xx = x |>
      dplyr::select(c("time", dplyr::starts_with("Q"))) |>
      tidyr::pivot_longer(cols = dplyr::starts_with("Q")) |>
      dplyr::mutate(year = as.numeric(format(.data$time, "%Y")),
                    doy = as.numeric(format(.data$time, "%j")))
    yy = dplyr::slice_max(xx, year)
    
    month_format = function(x){ month.abb[x] }
    
    gg = ggplot2::ggplot(data = xx,
                         mapping = ggplot2::aes(x = doy, 
                                                y = value, 
                                                group = year)) +
      ggplot2::geom_line(color = "grey", alpha = 0.5) +
      ggplot2::geom_line(data = yy,
                         mapping = ggplot2::aes(x = doy, 
                                                y = value),
                         color = "black") +
      ggplot2::labs(x = "Day of Year", 
                    y = "Heat transport (W)", 
                    caption = "data source: https://mocha.earth.miami.edu/mocha/data/index.html") +
      ggplot2::facet_wrap(~name, scales = "free_y")
    
    
  } else if (by == "year"){
    
    xx = x |>
      dplyr::select(c("time", dplyr::starts_with("Q"))) |>
      tidyr::pivot_longer(cols = dplyr::starts_with("Q")) |>
      dplyr::mutate(year = as.numeric(format(.data$time, "%Y")))
    
    mm = range(xx$year)
    gg = ggplot2::ggplot(data = xx, 
                         mapping = ggplot2::aes(x = year, 
                                                y = value, 
                                                group = year)) + 
      ggplot2::geom_boxplot() +
      ggplot2::labs(x = "Year", 
                    y = "Heat transport (W)", 
                    caption = "data source: https://mocha.earth.miami.edu/mocha/data/index.html") +
      ggplot2::scale_x_continuous(breaks = seq(from = mm[1]-1, to = mm[2]+1, by = 5)) +
      ggplot2::facet_wrap(~name, scale = "free_y")
    
  } else {
    
    y = x |>
      dplyr::select(c("time", dplyr::starts_with("Q"))) |>
      tidyr::pivot_longer(cols = dplyr::starts_with("Q"))
    
    gg =  ggplot2::ggplot(data = y,
                          mapping = ggplot2::aes(x = time, y = value)) +
      ggplot2::geom_line()
    
    if (smooth) gg = gg + ggplot2::geom_smooth(method = 'loess', formula = 'y ~ x')
    
    gg = gg + 
      ggplot2::labs(x = "Date",
                    y = "Heat transport (W)", 
                    caption = "data source: https://mocha.earth.miami.edu/mocha/data/index.html") + 
      ggplot2::facet_wrap(~name, scales = "free_y")
  }
  
  gg
}
