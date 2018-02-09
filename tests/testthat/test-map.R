context("map.R")

# Setup
data <- dplyr::filter(earthquake_data, COUNTRY == 'SPAIN')
map <- eq_map(data, 'EQ_PRIMARY')

test_that('eq_map: Returns a map with the proper number of cicles', {
  expect_is(map, 'leaflet')
})

test_that('eq_map: Latitude bounds are equals to the range of latitudes in input data', {
  lat_bounds <- map$x$limits$lat
  expect_equal(range(data$LATITUDE), lat_bounds)
})

test_that('eq_map: Longitude bounds are equals to the range of longitudes in input data', {
  lng_bounds <- map$x$limits$lng
  expect_equal(range(data$LONGITUDE), lng_bounds)
})
