#' Earthquake maps
#'
#' Generate maps based on NOAA earthquake data
#'
#' The function maps the epicenters (LATITUDE/LONGITUDE) and annotates each point with
#' a pop up window containing annotation data stored in a column of the data frame.
#' The user should be able to choose which column is used for the annotation in the pop-up
#' with a function argument named annot_col. Each earthquake should be shown with a circle,
#' and the radius of the circle should be proportional to the earthquake's
#' magnitude (EQ_PRIMARY).
#'
#' @param data NOAA earthquake data in a clean dataframe (after a call to \code{eq_clean_data})
#' @param annot_col The column that will be taken for anotaion of the earthquakes
#'
#' @return The leaflet map with the earthquake data
#' @export
#'
#' @examples
#' data %>%
#'   filter(COUNTRY == "MEXICO" & year(DATE) >= 2000) %>%
#'   eq_map(annot_col = "DATE")
#'
eq_map <- function(data, annot_col) {

  # Prepare the popup text, reading the proper column from the data
  popup_text <- data %>% dplyr::pull(annot_col) %>% as.character

  # Map it!
  leaflet::leaflet(data) %>%
    leaflet::addTiles() %>%
    leaflet::addCircleMarkers(lat = ~LATITUDE, lng = ~LONGITUDE,
                              radius = ~EQ_PRIMARY, weight = 1,
                              popup = popup_text)
}


#' Earthquake labels
#'
#' Create labels for earthquake data to be included in leaflet maps
#'
#' It takes the dataset as an argument and creates an HTML label that
#' can be used as the annotation text in the leaflet map. This function
#' puts together a character string for each earthquake that will show
#' the cleaned location (as cleaned by the eq_location_clean()
#' function), the magnitude (EQ_PRIMARY), and the total number of
#' deaths (TOTAL_DEATHS), with boldface labels for each
#' ("Location", "Total deaths", and "Magnitude"). If an earthquake is
#' missing values for any of these, both the label and the value should
#' be skipped for that element of the tag
#'
#' @param data NOAA earthquake data in a clean dataframe (after a call to \code{eq_clean_data})
#'
#' @return A character vector with the labels
#' @export
#'
#' @examples
#' data %>%
#'    filter(COUNTRY == "MEXICO" & year(DATE) >= 2000) %>%
#'    mutate(popup_text = eq_create_label(.)) %>%
#'    eq_map(annot_col = "popup_text")
#'
eq_create_label <- function(data) {
  # First of all, clean the location. It's not a problem if it is already clean
  data <- eq_location_clean(data)

  # Then generate the label, concatenating the three fields
  paste0(build_label('Location:', data$LOCATION_NAME),
         build_label('Magnitude:', data$EQ_PRIMARY),
         build_label('Total deaths:', data$DEATHS))
}

#' Build map label
#'
#' It builds the individual labels for the popup in the map.
#'
#' In the case of one value to be NA, the corresponding generated label is ''
#'
#' @param tag preffix, to be in bold. E.g. Location:
#' @param content values to be added after the tag
#'
#' @return
#'
#' @examples
#' build_label('Location:', c('Here', 'There', 'Nowhere'))
#'
build_label <- function(tag, content) {
  dplyr::if_else(is.na(content), '',
    paste0('<strong>', tag, '</strong> ', content, '<br>')
  )
}
