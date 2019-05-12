# These functions are (mostly) verbatim copies of functions from
# the rticles package, which is copyrighted to RStudio and licensed under
# GPL-3.

find_file <- function(template, file) {
  template <- system.file("rmarkdown",
                          "templates",
                          template,
                          file,
                          package = "rmdtemplates")
  if (template == "")
    stop("Couldn't find template file ", template, "/", file, call. = FALSE)
  template
}

find_resource <- function(template, file) {
  find_file(template, file.path("resources", file))
}

inherit_pdf_document <- function(...) {
  fmt <- bookdown::pdf_document2(...)

  fmt$inherits <- "pdf_document"
  fmt
}

pdf_document_format <- function(...,
                                extra_dependencies = NULL,
                                format,
                                template,
                                csl = NULL,
                                colorlinks = TRUE)
{
  # base format
  fmt <- inherit_pdf_document(...,
                              template = find_resource(format, template))

  pdf_pre_processor <- function(metadata,
                              input_file,
                              runtime,
                              knit_meta,
                              files_dir,
                              output_dir) {
    args <- c()

    has_yaml_parameter <- function(text, parameter) {
      length(grep(paste0("^", parameter, "\\s*:.*$"), text)) > 0
    }

    input_test <- read_utf8(input_file)

    if (!has_yaml_parameter(input_test, "indent"))
      args <- c(args, "--variable", "indent:yes")

    # # set the margin to 1 inch if no geometry options or document class specified
    # if (!has_yaml_parameter(input_test, "(geometry|documentclass)"))
    #   args <- c(args, "--variable", "geometry:margin=1in")

    # # use titling package to change title format to be more compact by default
    # if (!has_yaml_parameter(input_test, "compact-title"))
    #   args <- c(args, "--variable", "compact-title:yes")

    if (length(extra_dependencies) || has_latex_dependencies(knit_meta)) {
      extra_dependencies <- latex_dependencies(extra_dependencies)
      all_dependencies <- append(extra_dependencies,
                                 flatten_latex_dependencies(knit_meta))
      filename <- as_tmpfile(latex_dependencies_as_string(all_dependencies))
      if ("header-includes" %in% names(metadata)) {
        cat(c("", metadata[["header-includes"]]),
            sep = "\n",
            file = filename,
            append = TRUE)
      }
      args <- c(args, rmarkdown::includes_to_pandoc_args(
                        rmarkdown::includes(in_header = filename)))
    }
    args
  }

  pre_processor <- function(metadata,
                            input_file,
                            runtime,
                            knit_meta,
                            files_dir,
                            output_dir) {
    # save files dir (for generating intermediates)
    saved_files_dir <<- files_dir

    # use a geometry filter when we are using the "default" template
    if (identical(template, "default"))
      pdf_pre_processor(metadata, input_file, runtime, knit_meta, files_dir,
                        output_dir)
    else
      invisible(NULL)
  }


  # remove rmarkdown geometry settings
  fmt$pre_processor <- function(...) {
    c(pdf_pre_processor(...), "--variable", "tables=yes", "--standalone")
  }

  # add csl to pandoc_args
  if (!is.null(csl)) {
    fmt$pandoc$args <- c(fmt$pandoc$args,
                         "--csl",
                         rmarkdown::pandoc_path_arg(csl))
  }

  if (isTRUE(colorlinks)) {
    fmt$pandoc$args <- c(fmt$pandoc$args, "--variable", "colorlinks=yes")
  }

  fmt
}
