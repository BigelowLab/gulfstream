#' Plot gsgi data time series
#' 
#' @export
#' @param x the gsgi data
#' @param y ignored
#' @param smooth logical, if TRUE add a smoothing line
#' @param by chr, one of 'none' (default timeseries), 'month' (ghost plot by month over the years)
#'  or 'year' a box plot by year
#' @param ... ignored
#' @return a ggplot2 object
plot.gsgi = function(x, y, 
                     smooth = TRUE, 
                     by = c("none", "month", "year")[1], 
                     ...){
  
  month_format = function(x){ month.abb[x] }
  
  by = tolower(by[1])
  if (by == "month"){
    
    xx = dplyr::mutate(x, 
                       year = format(date, "%Y") |> as.numeric(), 
                       mon = format(date, "%m") |> as.numeric())
    yy = dplyr::slice_max(xx, year)
    gg = ggplot2::ggplot(data = xx, 
                         mapping = ggplot2::aes_(x = ~mon, 
                                                 y = ~dSST.deseason, 
                                                 group = ~year))  +
      ggplot2::geom_line(color = "grey", alpha = 0.5,) + 
      ggplot2::geom_line(data = yy,
                         mapping = ggplot2::aes_(x = ~mon, 
                                                 y = ~dSST.deseason),
                         color = "black", 
                         linewidth = 1.5,
                         show.legend = TRUE) +
      ggplot2::labs(x = "Month", y = "Gulf Stream SST Gradient Index",
                    caption = "data source: https://www2.whoi.edu/staff/ykwon/data/") +
      ggplot2::scale_x_continuous(label = month_format)
    
    
  } else if (by == "year"){
    
    xx = dplyr::mutate(x,
                       year = format(.data$date, "%Y") |> as.numeric()) 
    mm = range(xx$year)
    gg = ggplot2::ggplot(data = xx, 
                         mapping = ggplot2::aes_(x = ~year, y = ~dSST.deseason, group = ~year)) + 
      ggplot2::geom_boxplot() +
      ggplot2::labs(x = "Year", y = "Gulf Stream SST Gradient Index",
                    caption = "data source: https://www2.whoi.edu/staff/ykwon/data/") + 
      ggplot2::scale_x_continuous(breaks = seq(from = mm[1], to = mm[2], by = 5))
    
    if (smooth){
      gg = gg + 
        ggplot2::geom_smooth(method = 'loess', formula = 'y ~ x')
    }
    
  } else {
    
    gg = ggplot2::ggplot(data = x, ggplot2::aes(x = .data$date, y = .data$dSST.deseason)) + 
      ggplot2::geom_line() +
      ggplot2::labs(x = "Date", y = "dSST (deseasoned, C)", 
                    title = "Gulf Stream SST Gradient Index",
                    caption = "data source: https://www2.whoi.edu/staff/ykwon/data/")
    if (smooth){
      gg = gg + 
        ggplot2::geom_smooth(method = 'loess', formula = 'y ~ x')
    }
  }
  gg
}