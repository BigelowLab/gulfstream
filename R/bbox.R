#' Retrieve the preferred bounding box
#' 
#' @export
#' @param region chr one of "usn" or "northatlantic"
#' @return sfc_POLYGON object
gulfstream_bb = function(region = c("usn", "northatlantic")[1]){

  switch(tolower(region[1]),
              "usn" = c(xmin = -82,  ymin = 23.5,  xmax = -38,  ymax = 47.8),
              "northaltantic" = c(xmin = -100, ymin = 10, xmax = 10, ymax = 75),
              stop("region not known:", region[1])) |>
    sf::st_bbox( crs = 4326) |> 
    sf::st_as_sfc()
}