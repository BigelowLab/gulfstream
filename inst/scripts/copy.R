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
ofile = gulfstream_path("inst/extdata/mocha-rapid.rds")
x = gstream::read_rapid_mocha() |>
  saveRDS(ofile)

# transport-mocha
ofile = gulfstream_path("inst/extdata/mocha-transport.rds")
x = gstream::read_moc_transports() |>
  saveRDS(ofile)


# patches
ofile = gulfstream_path("inst/extdata/patch.rds")
x = gstream::read_patch_month() |>
  saveRDS(ofile)