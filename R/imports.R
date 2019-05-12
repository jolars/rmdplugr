# The following files are imported functions from rmarkdown, modified
# only by the commenting out of some lines and general code styling.
# rmarkdown is copyrighted to RStudio and licensed under
# GPL-3.

latex_dependencies_as_string <-
  utils::getFromNamespace("latex_dependencies_as_string", "rmarkdown")

has_latex_dependencies <-
  utils::getFromNamespace("has_latex_dependencies", "rmarkdown")

latex_dependencies <-
  utils::getFromNamespace("latex_dependencies", "rmarkdown")

flatten_latex_dependencies <-
  utils::getFromNamespace("flatten_latex_dependencies", "rmarkdown")

read_utf8 <-
  utils::getFromNamespace("read_utf8", "rmarkdown")

general_intermediates_generator <-
  utils::getFromNamespace("general_intermediates_generator", "rmarkdown")

rmarkdown_system_file <-
  utils::getFromNamespace("rmarkdown_system_file", "rmarkdown")

as_tmpfile <-
  utils::getFromNamespace("as_tmpfile", "rmarkdown")
