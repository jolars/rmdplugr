add_author_block <- function(x) {
  from <- grep("$if(author)$", x, fixed = TRUE)

  if (!length(from))
    warning("no author line in template, so do not know where to insert",
            "authors block.")

  end <- grep("$endif$", x, fixed = TRUE)
  to <- end[which(end - from > 0)[1]]

  author_block <- get_latex_addin("author-block")

  c(x[1:(from - 1)], author_block, x[(to+1):length(x)])
}

add_marginals <- function(x) {
  from <- grep("$for(header-includes)$", x, fixed = TRUE)

  if (!length(from))
    warning("no header-includes in template, so do not know where to insert",
            "authors block.")

  marginals <- get_latex_addin("marginals")

  c(x[1:(from-1)], marginals, x[from:length(x)])
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