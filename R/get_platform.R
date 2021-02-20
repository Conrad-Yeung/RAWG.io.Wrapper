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

library("httr")
library("jsonlite")

get_platform <- function(api_key = "", ordering="", Page="", Page_size=""){
  #TODO: Check for insertion attacks
  if (TRUE %in% grepl("&|%",c(api_key, ordering, Page, Page_size))){
    stop("Please do not try to mess with the GET request.")
  }
  
  #TODO: clean variables:
  cleaned_api_key="key="
  if(api_key != ""){
    cleaned_api_key=paste("key=",api_key,sep="")
  }
  
  cleaned_page="&page="
  if(Page != ""){
    cleaned_page = paste("&page=",Page,sep="")
  }
  
  cleaned_page_size="&page_size="
  if(Page_size != ""){
    cleaned_page_size = paste("&page_size=",Page_size, sep = "")
  }
  
  cleaned_ordering="&ordering"
  if(ordering != ""){
    cleaned_ordering = paste("&ordering=",ordering, sep = "")
  }
  
  #TODO: build url:
  link <- paste("https://api.rawg.io/api/platforms?",cleaned_api_key, cleaned_ordering, cleaned_page, cleaned_page_size)
  
  #TODO: run query:
  get_link <- GET(link) #GET REQUEST
  
  #Check if it is a successful connection
  if (get_link$status_code != 200){
    stop("Status code:",
         get_link$status_code,
         "\nurl:",
         get_link$url,
         "\nPlease double check the inputted parameters (i.e. make sure your API is correct")
  }
  
  raw_content <- fromJSON(content(get_link,"text",encoding="UTF-8"),simplifyVector=FALSE)
  results <- (raw_content$results)
  
  
  #TODO: dataframe wrangling
  
  
  results
}



