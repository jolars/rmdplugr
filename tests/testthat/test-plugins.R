test_that("plugins are correctly applied", {
  if (rmarkdown::pandoc_available()) {
    format <- pdf_article()
    expect_s3_class(format, "rmarkdown_output_format")

    format <- pdf_presentation()
    expect_s3_class(format, "rmarkdown_output_format")
  } else {
    expect_error(pdf_article())
    expect_error(pdf_presentation())
  }
})
