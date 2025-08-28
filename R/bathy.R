#' Read the bathymetry map
#' 
#' @export
#' @param filename chr, the name of the file
#' @return stars object
read_bathymetry = function(name = "usn",
                           filename = system.file(sprintf("extdata/bathy_%s.tif", name[1]),
                                                  package = "gulfstream")){
  stars::read_stars(filename)
}