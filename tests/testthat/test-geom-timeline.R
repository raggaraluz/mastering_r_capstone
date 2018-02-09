test_that('geom_timeline: The selected dates are filtered', {
  date_min <- lubridate::ymd('1433-01-01')
  date_max <- lubridate::ymd('1622-01-01')
  g <- ggplot2::ggplot(earthquake_data, ggplot2::aes(x = DATE)) +
    geom_timeline(xmin = date_min, xmax = date_max)


  data <- ggplot2::layer_data(g)
  plot_min <- min(data$x)
  plot_max <- max(data$x)

  expect_gte(plot_min, as.numeric(date_min))
  expect_lte(plot_max, as.numeric(date_max))
})
