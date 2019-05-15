
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rmdplugr

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/rmdplugr)](https://cran.r-project.org/package=rmdplugr)
[![Codecov test
coverage](https://codecov.io/gh/jolars/rmdplugr/branch/master/graph/badge.svg)](https://codecov.io/gh/jolars/rmdplugr?branch=master)
[![Travis build
status](https://travis-ci.org/jolars/rmdplugr.svg?branch=master)](https://travis-ci.org/jolars/rmdplugr)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/jolars/rmdplugr?branch=master&svg=true)](https://ci.appveyor.com/project/jolars/rmdplugr)
<!-- badges: end -->

rmdplugr modifies latex templates for Rmarkdown formats in order to

1.  restore style modifications caused by the default Rmarkdown and
    pandoc templates and
2.  enable additional modifications such as marginal material and author
    blocks.

The basic idea is that this package maintains to custom template and
instead inserts pandoc *plugins* (chunks) into the latex template in
order to provide modifications. The only requirement is that the
template to be modified (by default the default pandoc template gotten
from `pandoc -D latex`) contains a few lines from the standard template
so that rmdplugr knows where to insert the new template matter.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jolars/rmdplugr")
```
