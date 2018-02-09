context('geom-timeline-label.R')

test_that('geom_timeline_label: Check the label is properly stored in the aes', {
  g <- ggplot2::ggplot(earthquake_data,
                        ggplot2::aes(x = DATE, y = COUNTRY, label = LOCATION_NAME)) +
    geom_timeline_label()

  expect_equal(ggplot2::layer_data(g)$label, earthquake_data$LOCATION_NAME)
})
