test_that("scale functions behave correctly", {
  expect_s3_class(scale_color_okcolors(), "ScaleDiscrete")
  expect_s3_class(scale_fill_okcolors(discrete = FALSE), "ScaleContinuous")
})