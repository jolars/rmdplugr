test_that("plugins are correctly applied", {
  for (format in c(pdf_article, pdf_presentation)) {
    d <- format()
    expect_s3_class(d, "rmarkdown_output_format")
  }
})
