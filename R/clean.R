#' Clean NOAA data
#'
#' Clean NOAA Significant Earthquake Database and store it into a dataframe
#'
#' The clean data frame should have the following:
#' \enumerate{
#'    \item DATE column created by uniting the year, month, day and converting it to the Date class
#'    \item LATITUDE and LONGITUDE columns converted to numeric class
#' }
#'
#' @param raw Raw dataframe obtained after reading NOAA Significant Earthquake Database tab-separated file
#'
#' @return The clean dataframe after creating DATE column and transforming LATITUDE/LONGITUDE columns
#'
#' @importFrom magrittr "%>%"
#' @export
#'
#' @examples
#' clean <- eq_clean_data(earthquake_data_raw)
#'
eq_clean_data <- function(raw) {
  raw %>%
    # In case month and day are not available, set to 1
    dplyr::mutate(MONTH = dplyr::if_else(is.na(MONTH), 1L, MONTH), DAY = dplyr::if_else(is.na(DAY), 1L, DAY)) %>%
    # Nasty hack to support BC dates
    dplyr::mutate(DATE = lubridate::ymd(paste('0000', MONTH, DAY)) + lubridate::years(YEAR)) %>%
    dplyr::mutate(LONGITUDE = as.numeric(LONGITUDE), LATITUDE = as.numeric(LATITUDE))
}


#' Clean location
#'
#' Clean location from NOAA Significant Earthquake Database and return it as a vector
#'
#' Cleans the LOCATION_NAME column by stripping out the country name (including the colon) and converts names
#' to title case (as opposed to all caps). This function should be applied to the raw data to produce a cleaned
#' up version of the LOCATION_NAME column.
#'
#' @param raw Raw dataframe obtained after reading NOAA Significant Earthquake Database tab-separated file
#'
#' @return The clean dataframe after transforming LOCATION_NAME column
#'
#' @importFrom magrittr "%>%"
#' @export
#'
#' @examples
#' location_clean <- eq_location_clean(earthquake_data_raw)
#'
eq_location_clean <- function(raw) {
  raw %>%
    # String everything before a colon
    dplyr::mutate(LOCATION_NAME = stringr::str_replace(LOCATION_NAME, '^.*?:', '')) %>%
    # Trim spaces and title case
    dplyr::mutate(LOCATION_NAME = stringr::str_trim(LOCATION_NAME)) %>%
    dplyr::mutate(LOCATION_NAME = stringr::str_to_title(LOCATION_NAME))
}
