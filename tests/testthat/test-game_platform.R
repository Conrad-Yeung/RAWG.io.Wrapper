test_that("game_platform works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  
  #This is a simple query & should work
  test_list <- get_platform()
  expect_that(test_list, is_a("data.frame"))
  
  #This should throw an error (invalid API_Key)
  expect_error(get_publisher_list(api_key="BADKEY"))
  
  # #This should also throw an error (can't trick a query)
  # expect_error(get_publisher_list(api_key="page=10"))
  
})
