#' Retrieve the preferred bounding box
#' 
#' @export
#' @param x num, 4 elements vector with bbox coords
#' @return sfc_POLYGON object
usn_bb = function(x = c(xmin = -82,  ymin = 23.5,  xmax = -38,  ymax = 47.8)){
  x |>
    sf::st_bbox(bb, crs = 4326) |> 
    sf::st_as_sfc()
}

#' Plot a week-of-year map highighlighting the most recent data
#'
#' @export
#' @param x sf tibble - see `read_usn()`
#' @param y ignored
#' @param walls chr one of "north" (default) or "south"
#' @param iweek num, the week of year (starting with 1). Default is current week.
#'   If NULL then plot all available records for the wall.
#' @param most_recent num, the number of recent records to highlight
#' @param bb num, 4 element bounding box vector   
#' @param bathy NULL or stars, if NULL we read on for you
#' @param ... ignored
#' @return a ggplot2 object
plot.usn = function(x = read_usn(), y,
                     walls = "north",
                     iweek = lubridate::week(Sys.Date()),
                     most_recent = 4,
                     bb = usn_bb(),
                     bathy = read_bathymetry(),
                     ...){
  
  if(FALSE){
    walls = "north"
    x = read_usn()
    iweek = lubridate::week(Sys.Date())
    most_recent = 4
    bb = usn_bb()
    bathy = read_bathymetry()
  }
  
  if (!inherits(bb, "sfc")) bb = sf::st_bbox(bb, crs = 4326) |> sf::st_as_sfc()
  
  x = suppressWarnings(sf::st_crop(x, bb) |>
    dplyr::filter(wall %in% walls) |>
    dplyr::ungroup() |>
    dplyr::arrange(.data$date))
  
  recent = x |>
   dplyr::slice_tail(n = most_recent[1]) |>
    dplyr::mutate(Date = format(date, "%Y-%m-%d"))
  
  if (!is.null(iweek)){
    xweek = dplyr::filter(x, 
                          woy == iweek)
    
    #b = sf::st_bbox(bb)
    #xr = b[['xmax']] - b[['xmin']]
    #yr = b[['ymax']] - b[['ymin']]
    today = Sys.Date()
    lubridate::week(today) <- iweek
    
    #txt = dplyr::tibble(x = b[['xmin']] + 0.01*xr,
    #                    y = b[['ymax']] - 0.05*yr,
    #                    label = sprintf("Week %i starts %s", iweek,
    #                                    format(today, "%Y-%m-%d"))) |>
    #  sf::st_as_sf(coords = c("x", "y"), crs = sf::st_crs(x))
    caption = sprintf("Week %i starts %s\nsource: https://ocean.weather.gov/gulf_stream_latest.txt\nshowing %i earlier %s wall locations from the same week of year in grey", 
                      iweek,
                      format(today, "%Y-%m-%d"),
                      nrow(xweek),
                      paste(walls, collapse = " & "))
    gg = ggplot() +
      stars::geom_stars(data = bathy, show.legend = FALSE) + 
      #ggplot2::geom_text(data = txt,
      #                   mapping = ggplot2::aes(label = label)) + 
      ggplot2::geom_sf(data = xweek, 
              col = "grey", 
              alpha = 0.5) +
      ggplot2::geom_sf(data = recent,
              mapping = ggplot2::aes(color = Date),
              linewidth = 1) +
      ggplot2::theme_void() + 
      ggplot2::labs(caption = caption )
  } else {
    gg = ggplot() +
      stars::geom_stars(data = bathy, show.legend = FALSE) + 
      ggplot2::geom_sf(data = x, 
                       color = "grey",
                       alpha = 0.1) +
      ggplot2::geom_sf(data = recent,
                       mapping = ggplot2::aes(color = Date),
                       linewidth = 1) +
      ggplot2::theme_void() + 
      ggplot2::labs(caption = "source: https://ocean.weather.gov/gulf_stream_latest.txt")
  }
  gg
}
