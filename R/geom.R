#' @rdname geom_timeline
#' @importFrom magrittr "%>%"
GeomTimeline <- ggplot2::ggproto("GeomTimeline", ggplot2::Geom,
                     required_aes = c("x"),
                     non_missing_aes = c("size", "shape", "colour"),
                     default_aes = ggplot2::aes(
                       y = 0.25, shape = 21, colour = "black", size = 1.5, fill = 'black',
                       alpha = NA, stroke = 0.5
                     ),
                     extra_params = c("na.rm", "xmin", "xmax"),

                     setup_data = function(data, params) {
                       data <- data %>%
                         dplyr::filter(dplyr::between(x, params$xmin, params$xmax))
                     },

                     draw_panel = function(data, panel_params, coord, na.rm = FALSE) {
                       coords <- coord$transform(data, panel_params)

                       grid::pointsGrob(
                          coords$x, coords$y,
                          pch = coords$shape,
                          gp = grid::gpar(
                            col = ggplot2::alpha(coords$colour, coords$alpha),
                            fill = ggplot2::alpha(coords$fill, coords$alpha),
                            # Stroke is added around the outside of the point
                            fontsize = coords$size * ggplot2::.pt + coords$stroke * ggplot2::.stroke / 2,
                            lwd = coords$stroke * ggplot2::.stroke / 2
                          )
                       )
                     },

                     draw_key = ggplot2::draw_key_point
)

#' Timeline geom
#'
#' Timeline geom for earthquake data
#'
#' This geom is for plotting a time line of earthquakes ranging from xmin to xmax dates
#' with a point for each earthquake.
#' Optional aesthetics include color, size, and alpha (for transparency).
#'
#'
#' The x aesthetic is a date and an optional y aesthetic is a factor indicating
#' some stratification in which case multiple time lines will be plotted for each
#' level of the factor (e.g. country).
#'
#' @inheritParams ggplot2::geom_point
#' @param xmin Minimum date to represent
#' @param xmax Maximum date to represent
#'
#' @return Returns the geom for ggplot2 graphics
#' @export
#'
#' @rdname geom_timeline
#' @examples
#'
#' ggplot(data, aes(x = DATE, y = COUNTRY, size=EQ_PRIMARY, fill = DEATHS)) +
#'     geom_timeline(alpha = 0.25, xmin = ymd('2000-01-01'), xmax = ymd('2015-12-31')) +

geom_timeline <- function(mapping = NULL, data = NULL, stat = "identity",
                             position = "identity", na.rm = FALSE,
                             show.legend = NA, inherit.aes = TRUE,
                             xmin = as.Date('0001-01-01'), xmax = as.Date('2020-01-01'), ...) {
  ggplot2::layer(
    geom = GeomTimeline, mapping = mapping,
    data = data, stat = stat, position = position,
    show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, xmin = xmin, xmax = xmax, ...)
  )
}
