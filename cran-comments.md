## Test environments
* local ubuntu 19.04 install, R 3.6.1
* ubuntu 14.04 (on travis-ci), R 3.6.1
* win-builder (devel and release)
* Ubuntu Linux 16.04 LTS, R-release, GCC (on rhub)
* Fedora Linux, R-devel, clang, gfortran (on rhub)
* Windows Server 2008 R2 SP1, R-devel, 32/64 bit (on rhub)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## Resubmission
This is a resubmission. In this version I have:

* Disabled an example for pdf_article() that, as a side effect, 
created a file 'my-article.Rmd' in the working directory.
