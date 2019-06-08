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

split_at_headerincludes <- function(x) {
  start <- grep("$for(header-includes)$", x, fixed = TRUE)
  n <- length(x)

  # insert above begin document if no header includes
  if (!length(start))
    start <- grep("\\begin{document}", fixed = TRUE)

  if (!length(start))
    warning("no header-includes in template, so inserting block ",
            "above \\begin{document}")

  # Split template and return pieces
  list(top = x[1:(start-1)], bottom = x[start:n])
}

clip_and_split_at_block <- function(x, from, to = "$endif$", fixed = TRUE) {
  n <- length(x)

  start <- grep(from, x, fixed = fixed)[1]

  if (is.na(start)) {
    # fall back to headerincludes if place not found
    y <- split_at_headerincludes(x)
  } else {
    end <- grep(to, x, fixed = fixed)
    end <- end[which(end - start > 0)[1]]
    y <- list(top = x[1:(start - 1)], bottom = x[(end + 1):n])
  }

  y
}
