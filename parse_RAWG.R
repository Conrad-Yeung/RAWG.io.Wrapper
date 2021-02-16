library(docstring)
library(jsonlite)
parse_RAWG <- function(get_object){
  #' parse the GET request from RAWG 
  #'
  #' Convert the GET request from the get_game_list function into a JSON object, making the data available for extraction.
  #'
  #' @importFrom json fromJSON
  #' 
  #' @param get_object (list): Object returned from the GET function
  #'
  #' @return Returns a JSON object containing some general summary data as well as requested data
  #'
  #' @examples raw_data <- parse_RAWG(test)
  #' 
  
  raw_content <- fromJSON(content(get_object,"text",encoding="UTF-8"),simplifyVector=FALSE)
  return(raw_content)
}