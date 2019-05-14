# These functions are (mostly) verbatim copies of functions from
# the rticles package, which is copyrighted to RStudio and licensed under
# GPL-3.

find_file <- function(...) {
  file <- system.file(..., package = "rmdtemplates")
  if (file == "")
    stop("Couldn't find file ", file, call. = FALSE)
  file
}

find_latex_addin <- function(addin) {
  addin <- paste0(addin, ".latex")
  file <- find_file("latex-addins", addin)
  file
}

get_latex_addin <- function(addin) {
  file <- find_latex_addin(addin)
  readLines(file(file))
}

get_pandoc_template <- function(pandoc = NULL) {
  if (is.null(pandoc))
    pandoc <- find_pandoc()

  template <- system2(file.path(pandoc$dir, "pandoc"),
                      args = c("-D latex"),
                      stdout = TRUE)
  template
}
