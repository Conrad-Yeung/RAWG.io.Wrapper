Sys.setenv("R_TESTS" = "")
if (!require("testthat")) install.packages("testthat",repos = "http://cran.us.r-project.org")
if (!require("devtools")) install.packages("devtools",repos = "http://cran.us.r-project.org")
library(testthat)
library(RAWG.io.Wrapper)

#devtools::test("RAWG.io.Wrapper")
testthat::test_check("RAWG.io.Wrapper")
