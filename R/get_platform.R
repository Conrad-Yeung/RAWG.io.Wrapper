#' GET request to RAWG
#'
#' Submit RAWG query and receive RAWG response formatted as a data frame
#' 
#' @import httr
#' @import jsonlite
#' @import dplyr
#' @import tibble 

# params:
# api_key = ""
# ordering = ""
# page = ""
# page_size = ""

get_platform <- function(api_key = "", ordering="", page="", page_size=""){
  #TODO: Check for insertion attacks
  if (TRUE %in% grepl("&|%",c(api_key, ordering, page, page_size))){
    stop("Please do not try to mess with the GET request.")
  }
  
  #TODO: clean variables:
  cleaned_api_key=""
  cleaned_page=""
  cleaned_page_size=""
  cleaned_ordering=""
  
  #TODO: build url:
  link <- paste("https://api.rawg.io/api/platforms",cleaned_api_key, cleaned_ordering, cleaned_page, cleaned_page_size)
  
  #TODO: run query:
  get_link <- GET(link) #GET REQUEST
  raw_content <- fromJSON(content(get_link,"text",encoding="UTF-8"),simplifyVector=FALSE)
  raw_content
  
  #TODO: dataframe wrangling
}
get_platform()
