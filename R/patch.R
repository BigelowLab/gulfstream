
#' Compute differences of patch_month data
#' 
#' @export
#' @param x tibble of class "patch_month"
#' @param what chr, the name of the variable to plot
#' @return tibble with cold - warm difference
patch_month_diff = function(x = read_patch_month(), what = "median"){
  what = tolower(what[1])
  y = x |>
    dplyr::select(dplyr::all_of(c("date", "region", "source", what[1]))) |>
    dplyr::group_by(source) |>
    dplyr::group_map(
      function(tbl, key){
        tidyr::pivot_wider(tbl,
                           values_from = dplyr::all_of(what[1]),
                           names_from = dplyr::all_of("region")) |>
          dplyr::mutate(dT = .data$cold_blob - .data$warm_spot)
      }, .keep = TRUE) |>
    dplyr::bind_rows() |>
    dplyr::mutate(what = what)
  class(y) <- c("patch_month_diff", class(y))
  y
}


#' Plot patch_month data
#' 
#' @export
#' @param x tibble of class "patch_month"
#' @param y ignored
#' @param what chr, the name of the variable to plot
#' @param view chr the type of view. By default "diff"
#' @param ... ignored
#' @return ggplot2 object
plot.patch_month = function(x = read_patch_month(), y,
                            what = "median",
                            view = c("diff", "map"),
                            ...){
  
  what = tolower(what[1])
  if (!what %in% colnames(x)) stop("please specify a variable in x - this wasn't found:", what)
  view = tolower(view[1])
  switch(view,
         "diff" = {
                    d = patch_month_diff(x, what = what) 
                    gg = plot(d, ...) 
                    return(gg)
                  },
         "map" = {
           
           coast = read_coastline()
           bb = read_patch_bbs() |>
             dplyr::slice(1:2) |>
             dplyr::rename(region = "name")
           
           #bathy = read_bathymetry()
           gg = ggplot2::ggplot() + 
             ggplot2::geom_sf(data = coast) + 
             ggplot2::geom_sf(data = bb,
                              mapping = ggplot2::aes(color = region),
                              linewidth = 2, fill = NA) + 
             ggplot2::coord_sf(crs = "+proj=lcc +lat_1=50 +lat_2=65 +lon_0=-50")
           gg},
         NULL
        )
  
  
}

#' Plot patch_month difference data
#' 
#' @export
#' @param x tibble of class "patch_month_diff"
#' @param y ignored
#' @param ... ignored
#' @return ggplot2 object
plot.patch_month_diff = function(x = patch_month_diff(), y, 
                                ...){
  
  what = tolower(x$what[1])
  
  ggplot2::ggplot(data = x,
                  mapping = ggplot2::aes(x = date, y = dT )) +
    ggplot2::geom_line() +
    ggplot2::geom_smooth(method = 'loess', formula = 'y ~ x') + 
    ggplot2::labs(x = "Date", y = "cold - warm (C)",
                  title = sprintf("Cold Blob - Warm Spot using %s", what)) + 
    ggplot2::facet_wrap(~source, scales = "fixed", ncol = 1)
  
}