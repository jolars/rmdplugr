# rmdplugr 0.4.1

## Small changes

* Added center and verbatim environments to noindentafter latex plugin.

## Bug fixes

* Fixed error in author block resulting from new version of pandoc latex
  template. (Thanks Brian Ripley.)

# rmdplugr 0.4.0

* Wording of R Markdown was changed in the title in the DESCRIPTION.

# rmdplugr 0.3.0

* `dontrun{}` was removed from an example in `pdf_article()`. The example
now instead writes to a temporary file.
* Wording of R Markdown was changed in the DESCRIPTION

# rmdplugr 0.2.0

* `dontrun{}` has been added to an example in `pdf_article()` since it
  otherwise created a file in the working directory when `R CMD check` 
  was run.

# rmdplugr 0.1.0

* This is the first version of the package.
