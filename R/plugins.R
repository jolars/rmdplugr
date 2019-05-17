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

add_page_numbering <- function(x) {
  first <- grep("\\setbeamertemplate", x, fixed = TRUE)[1]

  if (!length(first))
    warning("no beamer lines in template, so do not know where to insert",
            "authors block.")

  page_numbering <- c(
    "\\setbeamertemplate{footline}[page number]"
  )

  c(x[1:(first - 1)], page_numbering, x[first:length(x)])
}

add_noindentafter <- function(x) {
  y <- split_at_headerincludes(x)
  noindentafter <- get_latex_plugin("noindentafter")
  c(y$top, noindentafter, y$bottom)
}

add_setbeamertemplate <- function(x) {
  y <- split_at_headerincludes(x)
  beamer_templating <- get_latex_plugin("setbeamertemplate")
  c(y$top, beamer_templating, y$bottom)
}