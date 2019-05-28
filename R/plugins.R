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

  if (!length(first))
    warning("no beamer lines in template, so do not know where to insert",
            "authors block.")

  frame_numbering <- c(
    "\\setbeamertemplate{footline}[frame number]"
  )

  c(x[1:(first - 1)], frame_numbering, x[first:length(x)])
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

