#' Read US Navy gulf stream wall data
#' 
#' Data are assembled and managed using the [gstream R package](https://github.com/BigelowLab/gstream), and then copied to this package.
#' 
#' @source <https://ocean.weather.gov/gulf_stream_text.php>
#' @export
#' @return sf LINESTRING table
#' #' @format Spatial data frame with columns
#' \describe{
#' \item{date}{Date class}
#' \item{wall}{either "north" or "south"}
#' \item{geom}{LINESTRING geometry}
#' }
read_usn = function(){
  file = system.file("extdata/usn.rds")
  readRDS(file)
}

#' Read Gulf Stream Index data
#' 
#' Data are assembled and managed using the [gstream R package](https://github.com/BigelowLab/gstream), and then copied to this package.
#'
#' @source <https://noaa-edab.github.io/ecodata/index.html>
#' @export
#' @return table
#' @format Data frame with columns
#' \describe{
#' \item{date}{Date class}
#' \item{Time}{numeric, year.month}
#' \item{Var}{character, grouping variable}
#' \item{Value}{numeric, value of index}
#' \item{EPU}{charcater, regional assignment label}
#' }
read_gsi = function(){
  file = system.file("extdata/gsi.rds")
  readRDS(file)
}

#' Read Gulf Stream Gradient Index data
#' 
#' Data are assembled and managed using the [gstream R package](https://github.com/BigelowLab/gstream), and then copied to this package.
#'
#' @source <https://www2.whoi.edu/staff/ykwon/data/>
#' @export
#' @return  table
#' @format data frame with columns
#' \describe{
#' \item{date}{Date class}
#' \item{SST.N.deseason}{numeric, deseasoned SST north}
#' \item{SST.S.deseason}{character, deseasoned SST south}
#' \item{dSST.deseason}{numeric, deseasoned SST difference}
#' }
read_gsgi = function(){
  file = system.file("extdata/gsgi.rds")
  readRDS(file)
}
