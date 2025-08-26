#' Read US Navy gulf stream wall data
#' 
#' Data are assembled and managed using the [gstream R package](https://github.com/BigelowLab/gstream), and then copied to this package.
#' 
#' @source <https://ocean.weather.gov/gulf_stream_text.php>
#' @export
#' @return sf LINESTRING table
#' #' @format Spatial data frame with the following variables
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
#' @format data frame with the following variables
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
#' @format data frame with the following variables
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

#' Read RAPID MOC transport data
#' 
#' Data are assembled and managed using the [gstream R package](https://github.com/BigelowLab/gstream), and then copied to this package.
#' Values are in Svedrups (Sv).
#' 
#'
#' @source <http://www.rapid.ac.uk/rapidmoc>
#' @export
#' @return  table
#' @format data frame with the following variables
#' \describe{
#' \item{date}{Date}
#' \item{moc_mar_hc10}{MOC transports}
#' \item{t_umo10}{Upper mid-ocean transport}
#' \item{t_gs10}{Florida Straits transport}
#' \item{t_ek10}{Ekman transport}
#' \item{t_therm10}{0-800m thermocline recirculation}
#' \item{t_aiw10}{800-1100m intermediate water}
#' \item{t_ud10}{1100-3000m upper North Atlantic Deep Water}
#' \item{t_ld10}{3000-5000m lower North Atlantic Deep Water}
#' \item{t_bw10}{> 5000m Antarctic Bottom Water}
#' }
read_moc_transports = function(){
  file = system.file("extdata/moc-transports.rds")
  readRDS(file)
}

#' Read RAPID-MOCHA heat transport data
#' 
#' Data are assembled and managed using the [gstream R package](https://github.com/BigelowLab/gstream), and then copied to this package.
#' 
#' @source <https://mocha.earth.miami.edu/mocha/data/index.html>
#' @export
#' @return  table
#' @format data frame with the following variables
#' \describe{
#' \item{Q_eddy}{The interior gyre component due to spatially correlated v_T variability across the interior. (W)}
#' \item{Q_ek}{Ekman heat transport (W)}
#' \item{Q_fc}{Florida Straits heat transport (W)}
#' \item{Q_gyre}{Basinwide gyre heat transport (W)}
#' \item{Q_int}{Heat transport for the rest of the interior to Africa (W)}
#' \item{Q_mo}{the sum of all the three interior components between the Bahamas and Africa (W)}
#' \item{Q_ot}{Basinwide overturning heat transport (W)}
#' \item{Q_sum}{Net meridional heat transport (W)}
#' \item{Q_wedge}{Heat transport for the "western boundary wedge" off Abaco (W)}
#' \item{T_basin}{time-varying basinwide mean potential temperature profile (degree_C)}
#' \item{T_basin_mean}{time-mean basinwide mean potential temperature profile (degree_C)}
#' \item{T_fc_fwt}{time-varying Florida Current flow-weighted potential temperature (degree_C)}
#' \item{V_basin}{time-varying basinwide mean transport profile (1e6 m2 s-1)}
#' \item{V_basin_mean}{time-mean basinwide mean transport profile (1e6 m2 s-1)}
#' \item{V_fc}{time-varying Florida Current transport profile (1e6 m2 s-1)}
#' \item{V_fc_mean}{time-mean Florida Current transport profile (1e6 m2 s-1)}
#' \item{trans_ek}{time-varying Ekman transport (Sv, calculated from ERA-I winds) (1e6 m3 s-1)}
#' \item{trans_fc}{time-varying Florida Current transport (1e6 m3 s-1)}
#' \item{maxmoc}{time-varying maximum value of MOC streamfunction (1e6 m3 s-1)}
#' \item{moc}{time-varying MOC streamfunction vs. depth (1e6 m3 s-1)}
#' \item{z}{the depth array (z) that corresponds to the profile variables (m)}
#' \item{julian_day}{Julian day 12-hr timestamp (days since 1950-01-01T00:00:00Z)}
#' \item{year}{Year the measurement occurred (NA)}
#' \item{month}{Month of the year when the measurement occurred (NA)}
#' \item{day}{Day of the month when the measurement occurred (NA)}
#' \item{hour}{Hour of the day when the measurement occurred(in UTC) (NA)}
#' }
read_rapid_mocha = function(){
  file = system.file("extdata/rapid_mocha.rds")
  readRDS(file)
}

#' Read cold-warm blob patch data for two data sources: OISST and ERSST
#' 
#' Data are assembled and managed using the [gstream R package](https://github.com/BigelowLab/gstream), and then copied to this package.
#' 
#' @source <https://www.ncei.noaa.gov/products/optimum-interpolation-sst>
#' @source <https://www.ncei.noaa.gov/products/extended-reconstructed-sst>
#' @export
#' @return  table
#' @format data frame with the following variables
#' \describe{
#' \item{date}{Date class for the month (always the first)}
#' \item{region}{chr, region name}
#' \item{source}{chr, data source}
#' \item{min}{min of values in region, deg C}
#' \item{q25}{25th percentile of values in region, deg C}
#' \item{median}{median of values in region, deg C}
#' \item{mean}{mean of values in region, deg C}
#' \item{q75}{75th percentile of values in region, deg C}
#' \item{max}{max of values in region, deg C}
#' }
read_patch_month = function(){
  file = system.file("extdata/patch_month.rds")
  readRDS(file)
}



#' Read cold-warm blob patch data for two data sources: OISST and ERSST
#' 
#' Data are assembled and managed using the [gstream R package](https://github.com/BigelowLab/gstream), and then copied to this package.
#' 
#' @source <https://www.ncei.noaa.gov/products/optimum-interpolation-sst>
#' @source <https://www.ncei.noaa.gov/products/extended-reconstructed-sst>
#' @export
#' @return sf table
#' @format spatial data frame with the following variables
#' \describe{
#' \item{name}{chr, the name of the region}
#' }
read_patch_bbs = function(){
  file = system.file("extdata/patch_bbs.rds")
  readRDS(file)
}


#' Read a simplified medium resolution coastline for the Northwest Atlantic
#' 
#' Clipped with this bounding box: xmin = -80, ymin = 30, xmax = -10, ymax = 66
#' 
#' @source <https://www.naturalearthdata.com/>
#' @export
#' @return sfc_GEOMETRY object
read_coastline = function(){
  file = system.file("extdata/coast_medium.rds")
  readRDS(file)
}
