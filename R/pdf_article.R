#' Rmarkdown template for an augmented version of the basic pandoc latex
#' template
#'
#' @param ... arguments passed down to [bookdown::pdf_document2()]
#' @param csl bibliography style in the `.csl` format
#' @param colorlinks should cross-references and links be
#'   colored?
#' @param number_sections whether sections should be numbered
#' @param md_extensions which markdown extensions to add
#' @param indent whether to use paragraph indentation or not. In the latter case
#'   paragraphs are separated by vertical space as in the default rmarkdown
#'   template.
#' @param marginals whether to augment latex template with marginals (header
#'   and footer) code
#' @param author_block wheter to augment latex template with author
#'   blocks. The latex packae authblk is required.
#' @param template template for latex output. If `NULL`, the default
#'   latex template will be used (obtained from calling `pandoc -D latex`).
#'
#' @return R Markdown output format to pass to [rmarkdown::render()]
#' @examples
#' library(rmarkdown)
#' library(bookdown)
#' rmarkdown::draft("my-article.Rmd",
#'                  template = "pdf_article",
#'                  package = "rmdtemplates",
#'                  edit = FALSE)
#' @export
pdf_article <- function(...,
                        number_sections = TRUE,
                        md_extensions = c("-autolink_bare_uris"),
                        indent = TRUE,
                        marginals = TRUE,
                        author_block = TRUE,
                        template = NULL,
                        csl = NULL,
                        colorlinks = TRUE)
{
  pandoc <- find_pandoc()

  # get template to modify
  if (is.null(template)) {
    template <- get_pandoc_template(pandoc)
  } else {
    template <- readLines(template)
  }

  if (author_block)
    template <- add_author_block(template)

  if (marginals)
    template <- add_marginals(template)

  # write augmented template to temporary file
  tmpfile <- tempfile(fileext = ".latex")
  writeLines(template, tmpfile)

  # base format
  fmt <- bookdown::pdf_document2(...,
                                 number_sections = number_sections,
                                 md_extensions = md_extensions,
                                 template = tmpfile)
  fmt$inherits <- "pdf_document"

  # delete modified latex template
  fmt$on_exit <- function() {
    unlink(tmpfile)
  }

  # add csl to pandoc_args
  if (!is.null(csl)) {
    fmt$pandoc$args <- c(fmt$pandoc$args,
                         "--csl",
                         rmarkdown::pandoc_path_arg(csl))
  }

  # indent by default
  if (isTRUE(indent))
    fmt$pandoc$args <- c(fmt$pandoc$args,
                         "--variable",
                         "indent:yes")

  fmt$pandoc$args <- c(fmt$pandoc$args,
                       "--variable",
                       "graphics:yes")

  if (isTRUE(colorlinks)) {
    fmt$pandoc$args <- c(fmt$pandoc$args,
                         "--variable",
                         "colorlinks:yes")
  }

  fmt
}

#' PDF presentation template
#'
#' @param ... arguments passed on to [rmarkdown::beamer_presentation()]
#' @param template what template to use. If `NULL`, the default
#'   latex template will be used.
#' @param page_numbering whether to add page numbers to latex template
#'
#' @inherit pdf_article return
#' @export
pdf_presentation <- function(...,
                             template = NULL,
                             page_numbering = TRUE) {

  if (is.null(template))
    template <- system2("pandoc", args = c("-D latex"), stdout = TRUE)
  else
    template <- readLines(template)

  if (page_numbering)
    template <- add_page_numbering(template)

  # write augmented template to temporary file
  tmpfile <- tempfile(fileext = ".latex")
  writeLines(template, tmpfile)

  fmt <- rmarkdown::beamer_presentation(..., template = tmpfile)

  # delete modified latex template
  fmt$on_exit <- function() {
    unlink(tmpfile)
  }

  fmt
}