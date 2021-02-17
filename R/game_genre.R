library(httr)
library(jsonlite)
library(dplyr)
library(tibble)

get_genre_list<-function(api_key=""){
  #' GET request to RAWG
  #'
  #' Submit RAWG query and receive RAWG response for game genres
  #'
  #' @importFrom httr GET
  #'
  #' @param api_key (str): your api key (recommended - not required, default = none)
  #'
  #' @return Large list containing response from RAWG query
  #'
  #' @examples 
  #' test<-get_genre_list()
  
  #Check if API Key is given
  if (api_key == ""){
    cleaned_api_key <- ""
  } else {
    cleaned_api_key <- paste("?key=",api_key,sep="")
  }
  
  link <- paste("https://api.rawg.io/api/genres",api_key,sep="")
  get_link <- GET(link)
  return(get_link)
}

parse_RAWG <- function(get_object){
  #' @title parse the GET request from RAWG 
  #'
  #' @description Convert the GET request from the get_game_list function into a JSON object, making the data available for extraction.
  #'
  #' @importFrom json fromJSON
  #' @import docstring
  #' 
  #' @param get_object (list): Object returned from the GET function
  #'
  #' @return Returns a JSON object containing some general summary data as well as requested data
  #'
  #' @examples raw_data <- parse_RAWG(test)
  
  raw_content <- fromJSON(content(get_object,"text",encoding="UTF-8"),simplifyVector=FALSE)
  
  #Return object
  return(raw_content)
}

extract_as.df_RAWG_genre <- function(parse_object){
  #' @title extract data from the RAWG JSON object
  #'
  #' @description Extracting the data from 'results' into a dataframe, removing certain fields such as subset of game information, image and following
  #' 
  #' @param parse_object (list): JSON object obtained from the parse_RAWG function
  #' 
  #' @return Returns a dataframe containing the extracted data from the GET function
  #' 
  #' @examples df <- extract_as.df_RAWG_genre(raw_genre)
  
  results <- (raw_genre$results)
  
  #Initial Run
  #Cleanup & Table values for A FIRST GAME
  data_raw <- results[[1]]
  names <- enframe(unlist(data_raw))
  temp_df <- data.frame(names)
  temp_df <- filter(temp_df,!temp_df$name %in% c("games.id","games.slug","games.name","games.added","image_background","following"))
  final_df <- temp_df
  
  for (entries in (2:length(results))){ #Do the same for all other N-1 games 
    #Cleanup & Table values for A SINGLE GENRE 
    data_raw <- results[[entries]]
    names <- enframe(unlist(data_raw))
    temp_df <- data.frame(names)
    temp_df <- filter(temp_df,!temp_df$name %in% c("games.id","games.slug","games.name","games.added","image_background","following"))
    
    #Prepping for merge
    final_df<-full_join(final_df, temp_df, by = "name") #Joining by 'name' column
  }
  
  final_df<-t(final_df)
  colnames(final_df) <- final_df[1,]
  final_df<-final_df[-1,]
  rownames(final_df)<-NULL
  return (final_df)
}