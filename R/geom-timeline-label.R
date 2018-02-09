#' Labels for timeline geom
#'
#' Labels for timeline geom for earthquake data
#'
#' TThis geom adds a vertical line to each data point with a text annotation
#' (e.g. the location of the earthquake) attached to each line.
#' Aesthetics are x, which is the date of the earthquake and label which
#' takes the column name from which annotations will be obtained.
#'
#' @inheritParams ggplot2::geom_text
#'
#' @return Returns the geom for ggplot2 graphics
#' @export
#'
#' @rdname geom_timeline_label
#' @examples
#' library(dplyr)
#' clean <- eq_clean_data(earthquake_data_raw) %>%
#'          eq_clean_location() %>%
#'          filter(COUNTRY %in% c('USA', 'CHINA'))
#'
#' labels <- data %>%
#'   top_earthquakes(10, ymd('2000-01-01'), ymd('2015-12-31'))
#'
#'
#' ggplot(data, aes(x = DATE, y = COUNTRY, fill = DEATHS)) +
#'   geom_timeline(aes(size = EQ_PRIMARY), alpha = 0.25, xmin = ymd('2000-01-01'), xmax = ymd('2015-12-31')) +
#'   geom_timeline_label(data = labels, mapping = aes(x = DATE, y = COUNTRY, label = LOCATION_NAME))
geom_timeline_label <- function(mapping = NULL, data = NULL,
                      stat = "identity",
                      position = "identity",
                      ...,
                      na.rm = FALSE,
                      show.legend = NA,
                      inherit.aes = TRUE)
{
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomTimelineLabel,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}


#' @rdname geom_timeline_label
#' @importFrom magrittr "%>%"
GeomTimelineLabel <- ggplot2::ggproto("GeomTimelineLabel", ggplot2::Geom,
                    required_aes = c("x", "label"),

                    default_aes = ggplot2::aes(
                      y = 0.25, colour = "black", size = 3.88, offset = 0.08, angle = 45,
                      alpha = NA, family = "", fontface = 1, lineheight = 1.2
                    ),

                    draw_panel = function(data, panel_params, coord, parse = FALSE,
                                          na.rm = FALSE, check_overlap = FALSE) {
                      lab <- data$label
                      data <- coord$transform(data, panel_params)

                      text <- grid::textGrob(
                        lab,
                        data$x, data$y + data$offset, default.units = "native",
                        just = 0,
                        rot = data$angle,
                        gp = grid::gpar(
                          col = alpha(data$colour, data$alpha),
                          fontsize = data$size * ggplot2::.pt,
                          fontfamily = data$family,
                          fontface = data$fontface,
                          lineheight = data$lineheight
                        )
                      )

                      lines <- grid::segmentsGrob(x0 = data$x,
                                                   x1 = data$x,
                                                   y0 = data$y,
                                                   y1 = data$y + data$offset,
                                                   default.units = "native",
                                                   gp = grid::gpar(lwd = data$lineheight))

                      grid::gTree(children = grid::gList(
                        text,
                        lines
                      ))
                    },

                    draw_key = ggplot2::draw_key_text
)
