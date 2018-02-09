test_that('top_earthquakes: Top contains exactly n_max columns', {
  top <- top_earthquakes(earthquake_data, 6)
  expect_equal(nrow(top), 6)
})

test_that('top_earthquakes: Tests date filter', {
  date_min <- lubridate::ymd('2008-01-01')
  date_max <- lubridate::ymd('2010-01-01')
  top <- top_earthquakes(earthquake_data, 7, date_min = date_min, date_max = date_max)
  expect_gte(as.numeric(min(top$DATE)), as.numeric(date_min))
  expect_lte(as.numeric(max(top$DATE)), as.numeric(date_max))
})
