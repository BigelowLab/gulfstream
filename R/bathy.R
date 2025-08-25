#' Read the bathymetry map
#' 
#' @export
#' @param filename chr, the name of the file
#' @return stars object
read_bathymetry = function(filename = system.file("extdata/bathy.tif",
                                                  package = "gulfstream")){
  stars::read_stars(filename)
}