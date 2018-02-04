GeomTimeline <- ggplot2::ggproto("GeomTimeline", ggplot2::Geom,
                               required_aes = c("x"),
                               default_aes = ggplot2::aes(y = 0.5, size = 1, alpha = 0.25),
                               draw_key = ggplot2::draw_key_point,
                               draw_panel = function(data, panel_scales, coord) {
                                 geom_point(aes(x = coord$x, y = coord$y,
                                                size = coord$size, alpha = coord$size))
                                 # ## Transform the data first
                                 # coords <- coord$transform(data, panel_scales)
                                 #
                                 # ## Compute the alpha transparency factor based on the
                                 # ## number of data points being plotted
                                 # ## Construct a grid grob
                                 # grid::pointsGrob(
                                 #   x = coords$x,
                                 #   y = coords$y,
                                 #   pch = 19,
                                 #   gp = grid::gpar(alpha = coords$alpha,
                                 #                   fontsize = coords$size * ggplot2::.pt)
                                 # )
                               })

#' @export
geom_timeline <- function(mapping = NULL, data = NULL, stat = "identity",
                             position = "identity", na.rm = FALSE,
                             show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer(
    geom = GeomTimeline, mapping = mapping,
    data = data, stat = stat, position = position,
    show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}
