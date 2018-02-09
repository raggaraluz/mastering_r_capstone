context('data.R')

test_that('earthquake_data_raw: have the proper number of dimensions',  {
  expect_equal(dim(earthquake_data_raw), c(5996, 47))
})

test_that('earthquake_data: have the proper number of dimensions',  {
  expect_equal(dim(earthquake_data), c(5996, 48))
})

