#' Custom ggplot2 Color Scale using okcolors Palettes
#'
#' Applies a custom discrete or continuous color scale to ggplot2 plots using a selected palette from the okcolors package.
#'
#' @param palette Character. Name of the palette to use. Must be one of the palettes available in `okcolors()`. Default is `"obsession"`.
#' @param discrete Logical. Whether to use a discrete scale (`TRUE`) or a continuous scale (`FALSE`). Default is `TRUE`.
#' @param direction Integer. If `1` (default), colors are as defined. If `-1`, the palette is reversed.
#' @param ... Additional arguments passed to `ggplot2::discrete_scale()` or `ggplot2::scale_color_gradientn()`.
#'
#' @return A `Scale` object that can be added to a ggplot2 plot.
#' @export
scale_color_okcolors <- function(palette = "obsession", discrete = TRUE, direction = 1, ...) {
  if (discrete) {
    ggplot2::discrete_scale(
      aesthetics = "colour",
      palette = function(n) okcolors(palette, n, direction = direction),
      ...
    )
  } else {
    pal_fn <- grDevices::colorRampPalette(okcolors(palette, direction = direction))
    ggplot2::scale_color_gradientn(colours = pal_fn(256), ...)
  }
}

#' Custom ggplot2 Fill Scale using okcolors Palettes
#'
#' Applies a custom discrete or continuous fill scale to ggplot2 plots using a selected palette from the okcolors package.
#'
#' @param palette Character. Name of the palette to use. Must be one of the palettes available in `okcolors()`. Default is `"obsession"`.
#' @param discrete Logical. Whether to use a discrete scale (`TRUE`) or a continuous scale (`FALSE`). Default is `TRUE`.
#' @param direction Integer. If `1` (default), colors are as defined. If `-1`, the palette is reversed.
#' @param ... Additional arguments passed to `ggplot2::discrete_scale()` or `ggplot2::scale_fill_gradientn()`.
#'
#' @return A `Scale` object that can be added to a ggplot2 plot.
#' @export
scale_fill_okcolors <- function(palette = "obsession", discrete = TRUE, direction = 1, ...) {
  if (discrete) {
    ggplot2::discrete_scale(
      aesthetics = "fill",
      palette = function(n) okcolors(palette, n, direction = direction),
      ...
    )
  } else {
    pal_fn <- grDevices::colorRampPalette(okcolors(palette, direction = direction))
    ggplot2::scale_fill_gradientn(colours = pal_fn(256), ...)
  }
}
