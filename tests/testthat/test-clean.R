context('clean.R')

test_that('eq_clean_data: Checking the clean data contains DATE column', {
  clean <- eq_clean_data(earthquake_data_raw)
  expect_match(names(clean), 'DATE', all=F)
})

test_that('eq_clean_data: Checking the year in DATE column is properly calculated', {
  clean <- eq_clean_data(earthquake_data_raw)
  expect_equal(earthquake_data_raw$YEAR, lubridate::year(clean$DATE))
})

test_that('eq_clean_data: Checking latitude and longitude are numeric', {
  clean <- eq_clean_data(earthquake_data_raw)
  expect_is(clean$LATITUDE, 'numeric')
  expect_is(clean$LONGITUDE, 'numeric')
})

test_that('eq_location_clean: Location name changed', {
  clean <- eq_location_clean(earthquake_data_raw)
  differences <- earthquake_data_raw$LOCATION_NAME != clean$LOCATION_NAME
  expect_equal(sum(!is.na(clean$LOCATION_NAME)), sum(differences, na.rm = T))
})

test_that('eq_location_clean: Checking the LOCATION is in title case', {
  clean <- eq_location_clean(earthquake_data_raw)
  expect_equal(clean$LOCATION_NAME, stringr::str_to_title(clean$LOCATION_NAME))
})
