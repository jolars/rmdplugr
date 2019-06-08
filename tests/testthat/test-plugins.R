test_that("plugins are correctly applied", {
  format <- pdf_article()
  expect_s3_class(format, "rmarkdown_output_format")

  format <- pdf_presentation()
  expect_s3_class(format, "rmarkdown_output_format")
})
