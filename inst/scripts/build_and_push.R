path = gulfstream::gulfstream_path()
devtools::install(path, upgrade = FALSE)

orig = setwd(path)

# commit
date = format(Sys.time(), "%Y-%m-%d %H:%M:%S")
msg = sprintf("git commit -a -m 'auto update %s'", date)
ok = system(msg)

# now push
ok = system("git push origin main")
setwd(orig)

