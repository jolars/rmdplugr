#' Rmarkdown template for an augmented version of the basic pandoc latex
#' template
#'
#' @inheritParams bookdown::pdf_document2
#' @param ... arguments passed down to [bookdown::pdf_document2()]
#' @param csl bibliography style in the `.csl` format
#' @param colorlinks should cross-references and links be
#'   colored?
#'
#' @return R Markdown output format to pass to [rmarkdown::render()]
#' @examples
#'
#' library(rmarkdown)
#' library(bookdown)
#' rmarkdown::draft("my-article.Rmd",
#'                  template = "pdf_pandoc",
#'                  package = "rmdtemplates",
#'                  edit = FALSE)
#' @export
pdf_pandoc <- function(...,
                       template = NULL,
                       number_sections = TRUE,
                       md_extensions = c("-autolink_bare_uris"),
                       csl = NULL,
                       colorlinks = TRUE)
{
  pdf_document_format(...,
                      number_sections = number_sections,
                      md_extensions = md_extensions,
                      template = template,
                      csl = NULL,
                      colorlinks = TRUE)
}
