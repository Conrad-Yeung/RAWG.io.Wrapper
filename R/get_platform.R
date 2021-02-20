#' GET request to RAWG
#'
#' Submit RAWG query and receive RAWG response formatted as a data frame
#' 
#' @import httr
#' @import jsonlite
#' @import dplyr
#' @import tibble 

get_platform <- function(api_key = "", ordering = "", page = "", page_size = ""){

  #Check for insertion attacks
  if (TRUE %in% grepl("&|%",c(api_key, ordering, page, page_size))){
    stop("Please do not try to mess with the GET request.")
  }

  #Parameter validation
  #clean api_key
  if (api_key == ""){
    cleaned_api_key= ""
  }else{
    cleaned_api_key <- paste("?key=", api_key,sep="")
  }

  #clean ordering
  if (ordering == ""){
    cleaned_ordering = ""
  }else{
    cleaned_ordering = paste("&ordering=", ordering, sep="")
  }

  #clean page
  if (page == ""){
    cleaned_page = ""
  }else{
    cleaned_page = paste("&page=", page, sep="")
  }

  #clean page_size
  if (page_size == ""){
    cleaned_page_size = ""
  }else{
    cleaned_page_size = paste("page_size=", page_size, sep="")
  }

  # Call the GET
  link <- paste("https://api.rawg.io/api/platforms?",cleaned_api_key, cleaned_ordering, cleaned_page, cleaned_page_size)
  get_link <- GET(link) #GET REQUEST

  #Check if it is a successful connection
  if (get_link$status_code != 200){
    
    stop("Status code: ", 
         get_link$status_code, 
         "\nurl:",
         get_link$url,
         "\nPlease double check the inputted parameters (i.e. make sure your API is correct)")
  }

  raw_content <- fromJSON(content(get_link,"text",encoding="UTF-8"),simplifyVector=FALSE) #FORMAT INTO JSON
  results <- (raw_content$results)
}

get_platform(page_size="12")

# api_key = "12345"
# ordering = ""
# page = ""
# page_size = ""
# 
# cleaned_api_key=""
# 
# if(api_key==""){
#   cleaned_api_key=""
# }else{
#   cleaned_api_key=paste("key=", api_key,sep="")
# }
# 
# cleaned_api_key
# link <- paste("https://api.rawg.io/api/platforms?",cleaned_api_key, cleaned_ordering, cleaned_page, cleaned_page_size)
# print(link)
# get_link <- GET(link) #GET REQUEST
# get_link$status_code
# 
# raw_content <- fromJSON(content(get_link,"text",encoding="UTF-8"),simplifyVector=FALSE)
# raw_content
