#' Filter earthquakes by magnitude
#'
#' Pick the top n_max earthquakes acoording to their magnitude.
#'
#' @param data Earthquake data
#' @param n_max Max number of earthquakes to pick
#' @param date_min Minimum date
#' @param date_max Maximum date
#'
#' @return A dataframe with the filtered data
#'
#' @importFrom magrittr "%>%"
#' @export
#'
#' @examples
#' top_10 <- top_earthquakes(earthquake_data_raw, 10)
#'
top_earthquakes <- function(data, n_max, date_min = -Inf, date_max = Inf) {
  data %>%
    dplyr::filter(dplyr::between(DATE, date_min, date_max)) %>%
    dplyr::top_n(n_max, EQ_PRIMARY) %>%
    dplyr::slice(1:abs(n_max))
}
