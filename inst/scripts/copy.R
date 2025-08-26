suppressPackageStartupMessages({
  library(gstream)
  library(gulfstream)
})

# USN gulf stream data 
ofile = gulfstream_path("inst/extdata/usn.rds")
x = gstream::read_usn(what = "ordered", deduplicate = TRUE) |>
  saveRDS(ofile)

# GSI
ofile = gulfstream_path("inst/extdata/gsi.rds")
x = gstream::read_gsi() |>
  saveRDS(file = ofile)

# GSGI
ofile = gulfstream_path("inst/extdata/gsgi.rds")
x = gstream::read_gsgi() |>
  saveRDS(ofile)
  
# rapid-mocha
ofile = gulfstream_path("inst/extdata/rapid_mocha.rds")
x = gstream::read_rapid_mocha() |>
  saveRDS(ofile)

# transport-mocha
ofile = gulfstream_path("inst/extdata/moc-transports.rds")
x = gstream::read_moc_transports() |>
  saveRDS(ofile)


# patches
ofile = gulfstream_path("inst/extdata/patch_bbs.rds")
x = gstream::read_patch_bbs() |>
  saveRDS(ofile)

ofile = gulfstream_path("inst/extdata/patch_month.rds")
x = gstream::read_patch_month() |>
  saveRDS(ofile)

# coastline
ofile = gulfstream_path("inst/extdata/coast_medium.rds")
coast = rnaturalearth::ne_coastline(returnclass = "sf", scale = "medium")
b = sf::st_bbox(c(xmin = -80, ymin = 30, xmax = -10, ymax = 66), crs = 4326)
cst = sf::st_crop(sf::st_geometry(sf::st_simplify(coast)), b) |>
  saveRDS(ofile)
