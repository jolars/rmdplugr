add_author_block <- function(x) {
  from <- grep("$if(author)$", x, fixed = TRUE)

  if (!length(from))
    warning("no author line in template, so do not know where to insert",
            "authors block.")

  end <- grep("$endif$", x, fixed = TRUE)
  to <- end[which(end - from > 0)[1]]

  author_block <- get_latex_plugin("author-block")

  c(x[1:(from - 1)], author_block, x[(to+1):length(x)])
}

add_marginals <- function(x) {
  y <- split_at_headerincludes(x)

  marginals <- get_latex_plugin("marginals")

  c(y$top, marginals, y$bottom)
}

add_frame_numbering <- function(x) {
  first <- grep("\\setbeamertemplate", x, fixed = TRUE)[1]

  frame_numbering <- "\\setbeamertemplate{footline}[frame number]"

  if (is.na(first)) {
    # fall back to adding at headerincludes if no beamertemplate lines
    y <- split_at_headerincludes(x)
    res <- c(y$top, frame_numbering, y$bottom)
  } else {
    res <- c(x[1:(first - 1)], frame_numbering, x[first:length(x)])
  }

  res
}

add_noindentafter <- function(x) {
  y <- split_at_headerincludes(x)
  noindentafter <- get_latex_plugin("noindentafter")
  c(y$top, noindentafter, y$bottom)
}

add_beamer_customization <- function(x) {
  y <- split_at_headerincludes(x)
  beamer_customization <- get_latex_plugin("beamer-customization")
  c(y$top, beamer_customization, y$bottom)
}

add_more_fontthemes <- function(x) {

  y <- clip_and_split_at_block(x, from = "$if(fonttheme)$")

  more_fontthemes <- get_latex_plugin("more-fontthemes")

  c(y$top, more_fontthemes, y$bottom)
}

add_subfigs <- function(x) {
  y <- split_at_headerincludes(x)

  add_subfigs <- get_latex_plugin("subfigs")

  c(y$top, add_subfigs, y$bottom)
}

