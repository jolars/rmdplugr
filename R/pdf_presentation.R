
#' PDF presentation template
#'
#' @param ... arguments passed on to [rmarkdown::beamer_presentation()]
#' @param template what template to use. If `NULL`, the default
#'   latex template will be used.
#' @param frame_numbering whether to add frame numbers to latex template
#' @param beamer_customization whether to add a block that allows
#'   use of `\\setbeamertemplate\{\}[]`, `\\setbeamerfont\{\}[]`
#'   through metadata blocks with analogous names and
#'   with items `item` and `value` for setting various options.
#' @param more_fontthemes whether to add a block that
#'   allows multiple fontthemes
#' @param subfigs whether to use the subfig package for subfig support
#'
#' @inherit pdf_article return
#' @export
pdf_presentation <- function(...,
                             template = NULL,
                             frame_numbering = TRUE,
                             beamer_customization = TRUE,
                             more_fontthemes = TRUE,
                             subfigs = TRUE) {

  if (!rmarkdown::pandoc_available())
    stop("needs pandoc to work")

  if (is.null(template))
    template <- system2("pandoc", args = c("-D latex"), stdout = TRUE)
  else
    template <- readLines(template)

  if (frame_numbering)
    template <- add_frame_numbering(template)

  if (beamer_customization)
    template <- add_beamer_customization(template)

  if (more_fontthemes)
    template <- add_more_fontthemes(template)

  if (subfigs)
    template <- add_subfigs(template)

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