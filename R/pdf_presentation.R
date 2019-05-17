
#' PDF presentation template
#'
#' @param ... arguments passed on to [rmarkdown::beamer_presentation()]
#' @param template what template to use. If `NULL`, the default
#'   latex template will be used.
#' @param page_numbering whether to add page numbers to latex template
#' @param setbeamertemplate whether to add a block that allows
#'   use of `\\setbeamertemplate\{\}[]` through a metadata block called
#'   `setbeamertemplate` with items `item` and `value` for the
#'   respective settings.
#'
#' @inherit pdf_article return
#' @export
pdf_presentation <- function(...,
                             template = NULL,
                             page_numbering = TRUE,
                             setbeamertemplate = TRUE) {

  if (is.null(template))
    template <- system2("pandoc", args = c("-D latex"), stdout = TRUE)
  else
    template <- readLines(template)

  if (page_numbering)
    template <- add_page_numbering(template)

  if (setbeamertemplate)
    template <- add_setbeamertemplate(template)

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