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
#' data <- read_tsv('https://www.ngdc.noaa.gov/nndc/struts/results?type_0=Exact&query_0=$ID&t=101650&s=13&d=189&dfn=signif.txt')
#' top_10 <- top_earthquakes(data, 10)
#'
top_earthquakes <- function(data, n_max, date_min = -Inf, date_max = Inf) {
  data %>%
    dplyr::filter(between(DATE, date_min, date_max)) %>%
    top_n(n_max, EQ_PRIMARY) %>%
    slice(1:abs(n_max))
}
