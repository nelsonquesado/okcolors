test_that("palettes have correct lengths and error handling", {
  for (pal in valid_palettes()) {
    expect_length(okcolors(pal, 4), 4)
  }
  expect_error(okcolors("unknown", 3))
})