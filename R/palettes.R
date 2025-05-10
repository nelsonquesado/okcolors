#' Retrieve a Color Palette from the okcolors package
#'
#' Returns a vector of `n` colors from a specified palette included in the okcolors package.
#'
#' @param palette Character. Name of the palette to use. One of `"it"`, `"stone"`, `"skyscrapers"`, `"obsession"`, or `"moment"`. Default is `"obsession"`.
#' @param n Integer. Number of colors to return. Default is `5`.
#' @param direction Integer. If `1` (default), returns the palette as is. If `-1`, reverses the order.
#'
#' @return A character vector of hex color codes of length `n`.
#'
#' @examples
#' okcolors("stone", 3)
#' okcolors("obsession", 7, direction = -1)
#'
#' @export
okcolors <- function(palette = "obsession", n = 5, direction = 1) {
  
  palettes <- list(
    it  = c('#330000', '#660000', '#cc0033', '#ff6699', '#ffcc99'),
    stone  = c('#ffccff', '#ff99cc', '#bc8553', '#dea466', '#c3dda2'),
    skyscrapers  = c('#ff3366', '#ff6633', '#ffcc66', '#33cccc', '#663366'),
    obsession  = c('#4561cf', '#45924c', '#f0cc36', '#e96cd2', '#f44f49'),
    moment  = c('#ff3366', '#e96cd2', '#ffccff', '#f99841', '#33cccc')
  )
  
  if (!palette %in% names(palettes)) {
    stop("Palette not found. Choose from: ", paste(names(palettes), collapse = ", "))
  } 
  
  pal <- palettes[[palette]]
  
  if (direction == -1) pal <- rev(pal)
  if (!direction %in% c(1, -1)) stop("Direction must be 1 or -1.")
  
  grDevices::colorRampPalette(pal)(n)
}
