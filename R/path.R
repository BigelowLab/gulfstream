#' Retrieve the gulfstream root path
#' 
#' @export
#' @param filename chr, the name of the file that contains the root path
#' @return the root data path
root_path = function(filename = "~/.gulfstream"){
  readLines(filename[1])
}

#' Set the gulfstream root path
#'
#' @export
#' @param path the path that defines the location of gulfstream root
#' @param filename the name the file to store the path as a single line of text
#' @return NULL invisibly
set_root_path <- function(path = "/mnt/s1/projects/ecocast/corecode/R/gulfstream",
                          filename = "~/.gulfstream"){
  cat(path, sep = "\n", file = filename)
  invisible(NULL)
}

#' Retrieve the gulfstream path
#'
#' @export
#' @param ... further arguments for \code{file.path()}
#' @param root the root path
#' @return character path description
gulfstream_path <- function(...,
                            root = root_path()) {
  
  file.path(root, ...)
}
