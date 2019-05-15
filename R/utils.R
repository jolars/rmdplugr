find_file <- function(...) {
  file <- system.file(..., package = "rmdplugr")
  if (file == "")
    stop("Couldn't find file ", file, call. = FALSE)
  file
}

find_latex_plugin <- function(plugin) {
  plugin <- paste0(plugin, ".latex")
  file <- find_file("latex-plugins", plugin)
  file
}

get_latex_plugin <- function(plugin) {
  plugin <- paste0(plugin, ".latex")
  file <- find_file("latex-plugins", plugin)
  # con <- file(file)
  out <- readLines(file)
  # close(con)
  out
}

get_pandoc_template <- function(pandoc = NULL) {
  if (is.null(pandoc))
    pandoc <- find_pandoc()

  template <- system2(file.path(pandoc$dir, "pandoc"),
                      args = c("-D latex"),
                      stdout = TRUE)
  template
}
