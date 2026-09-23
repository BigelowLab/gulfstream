suppressPackageStartupMessages({
  library(gulfstream)
  library(ggplot2)
})

width = 8
height = 9

# GSI
ofile = gulfstream_path("inst/shiny/images/gsi.png")
x = read_gsi() |>
  plot(by = "none")
ggsave(ofile, x, width = width, height = height)

# GSGI
ofile = gulfstream_path("inst/shiny/images/gsgi.png")
x = read_gsgi() |>
  plot(by = "none")
ggsave(ofile, x, width = width, height = height)

  
# rapid-mocha
ofile = gulfstream_path("inst/shiny/images/rapid_mocha.png")
x = read_rapid_mocha() |>
  plot(by = "none")
ggsave(ofile, x, width = width, height = height)

# transport-mocha
ofile = gulfstream_path("inst/shiny/images/moc-transports.png")
x = read_moc_transports() |>
  plot()
ggsave(ofile, x, width = width, height = height)



# patches
ofile = gulfstream_path("inst/shiny/images/patch_diff.png")
x = read_patch_month() |>
  plot()
ggsave(ofile, x, width = width, height = height)


# coastline
ofile = gulfstream_path("inst/extdata/coast_medium.rds")
coast = rnaturalearth::ne_coastline(returnclass = "sf", scale = "medium") |>
  sf::st_geometry() |>
  sf::st_simplify()
b = sf::st_bbox(c(xmin = -100, ymin = 10, xmax = 10, ymax = 75), crs = 4326)
cst = sf::st_crop(coast, b) |>
  saveRDS(ofile)
