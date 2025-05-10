test_that("okcolors() returns correct number of colors", {
  expect_length(okcolors("obsession", 5), 5)
  expect_length(okcolors("stone", 3), 3)
})

test_that("okcolors() returns hex color strings", {
  cols <- okcolors("moment", 4)
  expect_true(all(grepl("^#[A-Fa-f0-9]{6}$", cols)))
})

test_that("okcolors() fails with invalid palette name", {
  expect_error(okcolors("not_a_palette"), "Palette not found")
})

test_that("scale_color_okcolors works in ggplot (discrete)", {
  p <- ggplot2::ggplot(ggplot2::mpg, ggplot2::aes(class, fill = class)) +
    ggplot2::geom_bar() +
    scale_fill_okcolors("obsession")
  expect_s3_class(p, "ggplot")
})

test_that("scale_color_okcolors works in ggplot (continuous)", {
  p <- ggplot2::ggplot(ggplot2::mpg, ggplot2::aes(displ, hwy, color = hwy)) +
    ggplot2::geom_point() +
    scale_color_okcolors("stone", discrete = FALSE)
  expect_s3_class(p, "ggplot")
})

test_that("scale_fill_okcolors works with discrete fill", {
  p <- ggplot2::ggplot(ggplot2::mpg, ggplot2::aes(class, fill = class)) +
    ggplot2::geom_bar() +
    scale_fill_okcolors("skyscrapers")
  expect_s3_class(p, "ggplot")
})

test_that("scale_fill_okcolors works with continuous fill", {
  p <- ggplot2::ggplot(ggplot2::mpg, ggplot2::aes(displ, hwy, fill = hwy)) +
    ggplot2::geom_tile() +
    scale_fill_okcolors("moment", discrete = FALSE)
  expect_s3_class(p, "ggplot")
})
