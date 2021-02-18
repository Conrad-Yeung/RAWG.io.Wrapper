library(RAWG.io.Wrapper)

test_that("game_list works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  
  #This is a simple query & should work
  test_list <- get_game_list()
  expect_that(test_list, is_a("data.frame"))
  
  #A complex query using all parameters as such should work:
  test_list <- get_game_list(n=13,page=2,start_date="2000-01-01",end_date="2020-12-31",metacritic="50,75",platform="1",platform_count = 2, genre="1,2,3",ordering ="-added")
  expect_that(test_list,is_a("data.frame"))
  
  #Adding failing Parameters 
  #(n>40 or <1)
  expect_error(get_game_list(n=50))
  expect_error(get_game_list(n=-1))
  #Only Start Date or End Date or Start Date > End Date or incorrect date format
  expect_error(get_game_list(start_date = "1996-02-12")
  expect_error(get_game_list(start_date = "1996-02-12")
})
