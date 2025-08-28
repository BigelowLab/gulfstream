path = gulfstream::gulfstream_path()
devtools::document(path)
devtools::install(path, upgrade = FALSE)

orig = setwd(path)

# add
ok = system("git add *")

# commit
date = format(Sys.time(), "%Y-%m-%d %H:%M:%S")
msg = sprintf("git commit -a -m 'auto update %s'", date)
ok = system(msg)

# now push
ok = system("git push origin main")
setwd(orig)

