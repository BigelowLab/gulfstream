path = gulfstream::gulfstream_path()
devtools::install(path, upgrade = FALSE)

orig = setwd(path)
msg = sprintf("git commit -a -m 'autoupdate %s", format(Sys.time(), "%Y-%m-%d %H:%M:%S"))
ok = system(msg)
ok = system("git push origin main")
setwd(orig)

