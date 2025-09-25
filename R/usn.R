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
#' @param graphics chr, one of 'ggplot2' or 'leaflet' to specify the base plotting
#' @param ... ignored
#' @return a ggplot2 or leaflet object
plot.usn = function(x = read_usn(), y,
                    walls = "north",
                    iweek = lubridate::week(Sys.Date()),
                    most_recent = 4,
                    graphics = c("ggplot2", "leaflet")[2],
                    bb = gulfstream_bb("usn"),
                    bathy = read_bathymetry(),
                     ...){
  
  if(FALSE){
    walls = "north"
    x = read_usn()
    iweek = lubridate::week(Sys.Date())
    most_recent = 4
    bb = gulfstream_bb("usn")
    bathy = read_bathymetry()
    graphics = "leaflet"
  }
  
  # if (!inherits(bb, "sf")) bb = sf::st_bbox(bb, crs = 4326) |>
  #                               sf::st_as_sfc() |>
  #                               sf::st_as_sf()
  # 
  # x = suppressWarnings(sf::st_crop(x, bb) |>
  #   dplyr::filter(wall %in% walls) |>
  #   dplyr::ungroup() |>
  #   dplyr::arrange(.data$date))
  # 
  # recent = x |>
  #  dplyr::slice_tail(n = most_recent[1]) |>
  #   dplyr::mutate(Date = format(date, "%Y-%m-%d"))
  # 
  # if (!is.null(iweek)){
  #   xweek = dplyr::filter(x, 
  #                         woy == iweek)
  #   
  #   today = Sys.Date()
  #   lubridate::week(today) <- iweek
  # }
  
  if (tolower(graphics[1]) == "leaflet"){
    #recent_pal = leaflet::colorFactor("Dark2", domain = recent$Date)
    #if (!is.null(iweek)){
      # see https://github.com/rstudio/leaflet/issues/841
      # for the basemap selection
      gr = leaflet::leaflet() |>
        leaflet::addProviderTiles("Esri.OceanBasemap",
          options = leaflet::providerTileOptions(variant = "Ocean/World_Ocean_Base")) |>
        add_usn_layer(x = x,
                          walls = walls,
                          iweek = iweek,
                          most_recent = most_recent,
                          bb = bb)
        #leaflet::addPolylines(
        #  data = xweek,
        #  opacity = 0.2,
        #  weight = 2,
        #  color = "black",
        #  layerId = "base_polylines") |>
        #leaflet::addPolylines(
        #  data = recent,
        #  color = ~recent_pal(recent$Date),
        #  opacity = 1,
        #  weight = 3,
        #  label = ~Date,
        #  layerId = "week_polylines") |>
        #leaflet::addLegend("bottomright",
        #                   title = gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", 
        #                             sprintf("%s wall", paste(walls, collapse = " and ")), 
        #                              perl=TRUE),
        #                   pal = recent_pal,
        #                   values = ~Date,
        #                   data = recent,
        #                   opacity = 1)
    # else {
    #
    # # see https://github.com/rstudio/leaflet/issues/841
    # gr = leaflet::leaflet() |>
    #   leaflet::addProviderTiles("Esri.OceanBasemap",
    #                             options = leaflet::providerTileOptions(
    #                               devtools::documet(variant = "Ocean/World_Ocean_Base"))) |>
    #   add_usn_polylines(x = x,
    #                     walls = walls,
    #                     iweek = iweek,
    #                     most_recent = most_recent,
    #                     bb = bb)
        # leaflet::addPolylines(
        #   data = x,
        #   opacity = 0.05,
        #   weight = 1,
        #   color = "black",
        #   layerId = "base_polylines") |>
        # leaflet::addPolylines(
        #   data = recent,
        #   color = ~recent_pal(recent$Date),
        #   opacity = 1,
        #   weight = 3,
        #   label = ~Date,
        #   layerId = "base_polylines") |>
        # leaflet::addLegend("bottomright",
        #                    title = gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", 
        #                                 sprintf("%s wall", paste(walls, collapse = " and ")), 
        #                                 perl=TRUE),
        #                    pal = recent_pal,
        #                    values = ~Date,
        #                    data = recent,
        #                    opacity = 1)
    #}
    
  } else {
    
    #ggplot2
    if (!is.null(iweek)){
      
      b = sf::st_bbox(bb)
      label = gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", 
                   sprintf("%s wall", paste(walls, collapse = " and ")), 
                   perl=TRUE)
      xr = b[['xmax']] - b[['xmin']]
      yr = b[['ymax']] - b[['ymin']]
      txt = dplyr::tibble(x = b[['xmin']] + 0.01*xr,
                          y = b[['ymax']] - 0.05*yr,
                          label = label) |>
        sf::st_as_sf(coords = c("x", "y"), crs = sf::st_crs(x))
      caption = sprintf("Week %i starts %s\nsource: https://ocean.weather.gov/gulf_stream_latest.txt\nshowing %i earlier %s wall locations from the same week of year in grey", 
                        iweek,
                        format(today, "%Y-%m-%d"),
                        nrow(xweek),
                        paste(walls, collapse = " & "))
      gr = ggplot() +
        stars::geom_stars(data = bathy, show.legend = FALSE) + 
        ggplot2::geom_sf_text(data = txt,
                           mapping = ggplot2::aes(label = label),
                           hjust = 0) + 
        ggplot2::geom_sf(data = xweek, 
                col = "grey", 
                alpha = 0.5) +
        ggplot2::geom_sf(data = recent,
                mapping = ggplot2::aes(color = Date),
                linewidth = 1) +
        ggplot2::theme_void() + 
        ggplot2::labs(caption = caption )
    } else {
      gr = ggplot() +
        stars::geom_stars(data = bathy, show.legend = FALSE) + 
        ggplot2::geom_sf(data = x, 
                         color = "grey",
                         alpha = 0.05) +
        ggplot2::geom_sf(data = recent,
                         mapping = ggplot2::aes(color = Date),
                         linewidth = 1) +
        ggplot2::theme_void() + 
        ggplot2::labs(caption = "source: https://ocean.weather.gov/gulf_stream_latest.txt")
    }
  }
  gr
}


#' Add layers to a leaflet basemap
#' @rdname plot.usn
#' @export
add_usn_layer = function(map,
                             x = read_usn(),
                             walls = "north",
                             iweek = lubridate::week(Sys.Date()),
                             most_recent = 4,
                             bb = gulfstream_bb("usn")){
  if (FALSE){
    walls = "north"
    x = read_usn()
    iweek = lubridate::week(Sys.Date())
    most_recent = 4
    bb = gulfstream_bb("usn")
  }
  
 
  
  if (!inherits(bb, "sf")) bb = sf::st_bbox(bb, crs = 4326) |>
      sf::st_as_sfc() |>
      sf::st_as_sf()
  
  x = suppressWarnings(sf::st_crop(x, bb) |>
                         dplyr::filter(wall %in% walls) |>
                         dplyr::ungroup() |>
                         dplyr::arrange(.data$date))
  
  recent = x |>
    dplyr::slice_tail(n = most_recent[1]) |>
    dplyr::mutate(Date = format(date, "%Y-%m-%d"))
  
  b = sf::st_bbox(bb)
  recent_pal = leaflet::colorFactor("Dark2", domain = recent$Date)
  
  all_weeks = is.null(iweek)
  if (!all_weeks){
    xweek = dplyr::filter(x, 
                          woy == iweek)
    today = Sys.Date()
    lubridate::week(today) <- iweek
  } else {
    xweek = NULL
  }
  data = if(all_weeks) x else xweek
  opacity = if(all_weeks) 0.05 else 0.2
  weight = if(all_weeks) 1 else 2
  map |>                         
    leaflet::addPolylines(
      data = data,
      opacity = opacity,
      weight = weight,
      color = "black",
      group = "base_polylines") |>
   leaflet::addPolylines(
     data = recent,
     color = ~recent_pal(recent$Date),
     opacity = 1,
     weight = 3,
     label = ~Date,
     group = "week_polylines") |>
   leaflet::addLegend("bottomright",
                      title = gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", 
                                   sprintf("%s wall", paste(walls, collapse = " and ")), 
                                   perl=TRUE),
                      pal = recent_pal,
                      values = ~Date,
                      data = recent,
                      opacity = 1)
}
