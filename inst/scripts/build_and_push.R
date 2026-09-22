
remotes::install_github("NOAA-EDAB/ecodata", upgrade = FALSE)

# here we update copies of the datasets (so we have the freshest)

# USN gulf stream data 
ofile = gulfstream::gulfstream_path("inst/extdata/usn.rds")
x = gstream::read_usn(what = "ordered", deduplicate = TRUE) |>
  saveRDS(ofile)

# GSI
ofile = gulfstream::gulfstream_path("inst/extdata/gsi.rds")
x = gstream::read_gsi() |>
  saveRDS(file = ofile)

# GSGI
ofile = gulfstream::gulfstream_path("inst/extdata/gsgi.rds")
x = gstream::read_gsgi() |>
  saveRDS(ofile)

# rapid-mocha
ofile = gulfstream::gulfstream_path("inst/extdata/rapid_mocha.rds")
x = gstream::read_rapid_mocha() |>
  saveRDS(ofile)

# transport-mocha
ofile = gulfstream::gulfstream_path("inst/extdata/moc-transports.rds")
x = gstream::read_moc_transports() |>
  saveRDS(ofile)

# patches
ofile = gulfstream::gulfstream_path("inst/extdata/patch_bbs.rds")
x = gstream::read_patch_bbs() |>
  saveRDS(ofile)

ofile = gulfstream::gulfstream_path("inst/extdata/patch_month.rds")
x = gstream::read_patch_month() |>
  saveRDS(ofile)

# coastline
ofile = gulfstream::gulfstream_path("inst/extdata/coast_medium.rds")
coast = rnaturalearth::ne_coastline(returnclass = "sf", scale = "medium") |>
  sf::st_geometry() |>
  sf::st_simplify()
b = sf::st_bbox(c(xmin = -100, ymin = 10, xmax = 10, ymax = 75), crs = 4326)
cst = sf::st_crop(coast, b) |>
  saveRDS(ofile)



# Here we document and install the package
path = gulfstream::gulfstream_path()
devtools::document(path)
devtools::install(path, upgrade = FALSE)


orig = setwd(path)

# finally update the github version
# add
ok = system("git add *")

# commit
date = format(Sys.time(), "%Y-%m-%d %H:%M:%S")
msg = sprintf("git commit -a -m 'auto update %s'", date)
ok = system(msg)

# now push
ok = system("git push origin main")
setwd(orig)

