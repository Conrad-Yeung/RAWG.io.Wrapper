#' GET request to RAWG
#'
#' Submit RAWG query and receive RAWG response for game publishers
#'
#' @import httr
#' @import jsonlite
#' @import dplyr
#' @import tibble
#'
#' @param api_key (str): your api key (recommended - not required, default = none)
#'
#' @return Return Data.Frame with list of publishers
#'
#' @export
#'
#' @examples 
#' test<-get_publisher_list()

#Check for insertion attacks

get_genre_list<-function(api_key=""){

  if (TRUE %in% grepl("&|%",api_key)){
    stop("Please do not try to mess with the GET request.")
  }
  
  #Check if API Key is given
  if (api_key == ""){
    cleaned_api_key <- ""
  } else {
    cleaned_api_key <- paste("?key=",api_key,sep="")
  }
  
  link <- paste("https://api.rawg.io/api/publishers",cleaned_api_key,sep="")
  get_link <- GET(link) #GET REQUEST
  
  #Check if it is a successful connection
  if (get_link$status_code != 200){
    stop("Please double check the inputted parameters (i.e. make sure your API is correct")
  }
  
  raw_content <- fromJSON(content(get_link,"text",encoding="UTF-8"),simplifyVector=FALSE) #FORMAT INTO JSON
  
  results <- (raw_content$results)
  
  #Cleaning and Formatting 
  #Initial Run
  #Cleanup & Table values for the FIRST PUBLISHER
  data_raw <- results[[1]]
  names <- enframe(unlist(data_raw))
  temp_df <- data.frame(names)
  temp_df <- filter(temp_df,!temp_df$name %in% c("games.id","games.slug","games.name","games.added","image_background","following"))
  final_df <- temp_df
  
  for (entries in (2:length(results))){ #Do the same for all other N-1 games 
    #Cleanup & Table values for A SINGLE PUBLISHER 
    data_raw <- results[[entries]]
    names <- enframe(unlist(data_raw))
    temp_df <- data.frame(names)
    temp_df <- filter(temp_df,!temp_df$name %in% c("games.id","games.slug","games.name","games.added","image_background","following"))
    
    #Prepping for merge
    final_df<-full_join(final_df, temp_df, by = "name") #Joining by 'name' column
  }
  
  #Cleaning up Data.frame
  final_df<-t(final_df)
  colnames(final_df) <- final_df[1,]
  final_df<-final_df[-1,]
  rownames(final_df)<-NULL
  final_df<-data.frame(final_df)
  
  #Return object
  return (final_df)
}
