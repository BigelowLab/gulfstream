Gulf Stream related data
================

The [gulfstream R package](https://github.com/BigelowLab/gulfstream)
serves [Gulf
Stream](https://www.nesdis.noaa.gov/about/k-12-education/oceans-coasts/what-the-gulf-stream)
related data from a single package. All data are actively harvested and
maintained using the [gstream R
package](https://github.com/BigelowLab/gstream), but the [gulfstream R
package](https://github.com/BigelowLab/gulfstream) is used for
convenient serving of the same data in a portable package.

## Requirements

- [R v4.2+](https://www.r-project.org/)
- [rlang](https://CRAN.R-project.org/package=rlang)
- [dplyr](https://CRAN.R-project.org/package=dplyr)
- [tidyr](https://CRAN.R-project.org/package=tidyr)
- [ggplot2](https://CRAN.R-project.org/package=ggplot2)
- [lubridate](https://CRAN.R-project.org/package=lubridate)
- [sf](https://CRAN.R-project.org/package=sf)
- [leaflet](https://CRAN.R-project.org/package=leaflet)
- [shiny](https://CRAN.R-project.org/package=shiny)

## Installation

    remotes::install_github("BigelowLab/gulfstream")

# Data

## Gulf Stream Index (GSI)

The [Gulf Stream
Index](https://en.wikipedia.org/wiki/Latitude_of_the_Gulf_Stream_and_the_Gulf_Stream_north_wall_index)
provides a positional index. Data are provides via the
[ecodata](https://noaa-edab.github.io/ecodata/) R package.

``` r
suppressPackageStartupMessages({
  library(dplyr)
  library(gulfstream)
})

read_gsi() |>
  glimpse()
```

    ## Rows: 1,722
    ## Columns: 6
    ## $ date  <date> 1954-01-01, 1954-01-01, 1954-02-01, 1954-02-01, 1954-03-01, 195…
    ## $ X     <int> 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, …
    ## $ Time  <dbl> 1954.01, 1954.01, 1954.02, 1954.02, 1954.03, 1954.03, 1954.04, 1…
    ## $ Var   <chr> "gulf stream index", "western gulf stream index", "gulf stream i…
    ## $ Value <dbl> 1.71647691, 0.56267542, 1.90634918, 0.57679479, 1.56230213, 0.77…
    ## $ EPU   <chr> "All", "All", "All", "All", "All", "All", "All", "All", "All", "…

## Gulf Stream SST Gradient Index (GSGI)

[Parfitt, Kwon, and Andres,
2022](https://agupubs.onlinelibrary.wiley.com/doi/10.1029/2022GL100914)
proposed a Gulf Stream Gradient Index. Data is served for 2004-2019
[here](https://www2.whoi.edu/staff/ykwon/data/).

> Parfitt, R., Y.-O. Kwon, and M. Andres, 2022: A monthly index for the
> large-scale sea surface temperature gradient across the separated Gulf
> Stream. Geophys. Res. Lett., 49, e2022GL100914.
> <https://doi.org/10.1029/2022GL100914>.

``` r
read_gsgi() |>
  glimpse()
```

    ## Rows: 324
    ## Columns: 4
    ## $ date           <date> 1993-01-01, 1993-02-01, 1993-03-01, 1993-04-01, 1993-0…
    ## $ SST.N.deseason <dbl> -0.73139479, 0.37673571, 0.55352506, 0.89345027, 0.2047…
    ## $ SST.S.deseason <dbl> -0.29115456, -0.34953310, -0.35755056, -0.29019442, -0.…
    ## $ dSST.deseason  <dbl> -0.44024022, 0.72626881, 0.91107561, 1.18364469, 0.5361…

## Data from [RAPID](https://rapid.ac.uk)

### [RAPID-AMOC](https://rapid.ac.uk/rapidmoc)

Data from the RAPID AMOC monitoring project is funded by the Natural
Environment Research Council and are freely available from
www.rapid.ac.uk/rapidmoc.

Reference for Version v2020.2 \>Moat B.I.; Frajka-Williams E., Smeed
D.A.; Rayner D.; Johns W.E.; Baringer M.O.; Volkov, D.; Collins, J.
(2022). Atlantic meridional overturning circulation observed by the
RAPID-MOCHA-WBTS (RAPID-Meridional Overturning Circulation and Heatflux
Array-Western Boundary Time Series) array at 26N from 2004 to 2020
(v2020.2), British Oceanographic Data Centre - Natural Environment
Research Council, UK. <doi:10.5285/e91b10af-6f0a-7fa7-e053-6c86abc05a09>

``` r
read_moc_transports()|>
  glimpse()
```

    ## Rows: 14,599
    ## Columns: 10
    ## $ date         <date> 2004-01-02, 2004-01-02, 2004-01-03, 2004-01-03, 2004-01-…
    ## $ t_therm10    <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, -16.84892, -17.07…
    ## $ t_aiw10      <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 0.7866466, 0.7543…
    ## $ t_ud10       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, -10.24242, -10.24…
    ## $ t_ld10       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, -3.384708, -3.561…
    ## $ t_bw10       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 1.4475944, 1.4028…
    ## $ t_gs10       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 29.36268, 29.2590…
    ## $ t_ek10       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, -1.1396932, -0.55…
    ## $ t_umo10      <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, -16.01807, -16.27…
    ## $ moc_mar_hc10 <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 12.22379, 12.4505…

### [RAPID-MOCHA](https://mocha.earth.miami.edu/mocha/data/index.html)

RAPID-MOCHA provides a heat transport time series.

``` r
read_rapid_mocha() |>
  glimpse()
```

    ## Rows: 12,202
    ## Columns: 19
    ## $ time       <dttm> 2004-04-02 00:00:00, 2004-04-02 12:00:00, 2004-04-03 00:00…
    ## $ Q_eddy     <dbl> 5.689694e+13, 5.508646e+13, 5.332703e+13, 5.167863e+13, 5.0…
    ## $ Q_ek       <dbl> -1.455417e+14, -1.617927e+14, -1.778214e+14, -1.919228e+14,…
    ## $ Q_fc       <dbl> 2.153860e+15, 2.179862e+15, 2.203375e+15, 2.223300e+15, 2.2…
    ## $ Q_gyre     <dbl> 1.354565e+14, 1.345823e+14, 1.338101e+14, 1.331889e+14, 1.3…
    ## $ Q_int      <dbl> -1.668320e+15, -1.665047e+15, -1.662643e+15, -1.662057e+15,…
    ## $ Q_mo       <dbl> -1.414269e+15, -1.407616e+15, -1.400726e+15, -1.394223e+15,…
    ## $ Q_ot       <dbl> 4.585924e+14, 4.758707e+14, 4.910170e+14, 5.039655e+14, 5.1…
    ## $ Q_sum      <dbl> 5.940489e+14, 6.104530e+14, 6.248270e+14, 6.371544e+14, 6.4…
    ## $ Q_wedge    <dbl> 1.971534e+14, 2.023443e+14, 2.085901e+14, 2.161555e+14, 2.2…
    ## $ T_fc_fwt   <dbl> 19.11297, 19.11348, 19.11400, 19.11454, 19.11511, 19.11573,…
    ## $ trans_ek   <dbl> -1.6293229, -1.8095506, -1.9872548, -2.1434514, -2.2586002,…
    ## $ trans_fc   <dbl> 27.56607, 27.89806, 28.19822, 28.45247, 28.65009, 28.78458,…
    ## $ maxmoc     <dbl> 9.153097, 9.584503, 9.978900, 10.325347, 10.617973, 10.8569…
    ## $ julian_day <dbl> 2453098, 2453098, 2453099, 2453100, 2453100, 2453100, 24531…
    ## $ year       <dbl> 2004, 2004, 2004, 2004, 2004, 2004, 2004, 2004, 2004, 2004,…
    ## $ month      <dbl> 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,…
    ## $ day        <dbl> 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11,…
    ## $ hour       <dbl> 0, 12, 0, 12, 0, 12, 0, 12, 0, 12, 0, 12, 0, 12, 0, 12, 0, …

## Gulf Stream Wall locations from US Navy

The daily data is hosted by by [NOAA’s Ocean Prediction
Center](https://ocean.weather.gov/) In particular they post the US
Navy’s [daily Gulf Stream point
data](https://ocean.weather.gov/gulf_stream_latest.txt) for the north
and south walls.

``` r
read_usn()
```

    ## Simple feature collection with 4337 features and 3 fields
    ## Geometry type: LINESTRING
    ## Dimension:     XY
    ## Bounding box:  xmin: -89.4 ymin: 20.7 xmax: -30.9 ymax: 47.8
    ## Geodetic CRS:  WGS 84
    ## # A tibble: 4,337 × 4
    ##    date         woy wall                                                    geom
    ##  * <date>     <dbl> <chr>                                       <LINESTRING [°]>
    ##  1 2010-01-22     4 north (-80.2 25, -80 25.1, -79.9 25.4, -80 25.5, -80 25.6, …
    ##  2 2010-01-22     4 south (-78.7 27.5, -78.8 27.5, -79 27.5, -79.1 27.5, -79.2 …
    ##  3 2010-01-25     4 north (-80.4 25, -80.2 25.1, -80.1 25.3, -80.1 25.5, -80 25…
    ##  4 2010-01-25     4 south (-78.7 27.5, -78.8 27.7, -79 27.7, -79.1 27.9, -79.1 …
    ##  5 2010-01-27     4 north (-80.3 25, -80.1 25.2, -80 25.6, -80 26, -79.9 26.5, …
    ##  6 2010-01-27     4 south (-78.8 27.5, -78.9 27.5, -78.9 27.6, -79 27.7, -79 27…
    ##  7 2010-01-29     5 north (-80.3 25, -80.1 25.2, -80 25.6, -80 26, -79.9 26.5, …
    ##  8 2010-01-29     5 south (-79.4 28.7, -79.5 28.9, -79.4 29.1, -79.4 29.2, -79.…
    ##  9 2010-02-01     5 north (-80.3 25, -80.1 25.2, -80 25.6, -80 26, -79.9 26.5, …
    ## 10 2010-02-01     5 south (-79.4 28.7, -79.5 28.9, -79.4 29.1, -79.4 29.2, -79.…
    ## # ℹ 4,327 more rows
