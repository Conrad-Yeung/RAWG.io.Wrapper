library(docstring)
extract_as.df_RAWG <- function(parse_obj){
  #' @title extract data from the RAWG JSON object
  #'
  #' @description Extracting the data from 'results' into a dataframe, removing certain fields such as images,screenshots, stores and tags
  #' 
  #' @param parse_object (list): JSON object obtained from the parse_RAWG function
  #' 
  #' @return Returns a dataframe containing the extracted data from the GET function
  #' 
  #' @examples df <- extract_as.df_RAWG(raw_data)
  
  results <- (parse_object$results)
  
  #Initial Run
  #Cleanup & Table values for A FIRST GAME 
  data_raw <- results[[1]]
  names <- enframe(unlist(data_raw))
  temp_df <- data.frame(names)
  temp_df <- temp_df[!grepl("tags|screenshots|store|image|requirements", temp_df$name),]
  
  #Create Unique Labeling - prepping for merge
  uniquify_list <- c("ratings.id","platforms.platform.id","parent_platforms.platform.id","genres.id")
  stop_list <- c("ratings.percent","platforms.released_at","parent_platforms.platform.slug","genres.games_count")
  id <- ""
  
  for (i in 1:length(temp_df$name)){
    if (temp_df$name[i] %in% uniquify_list){
      id <- temp_df[i,"value"]
    }else if (temp_df$name[i] %in% stop_list){
      temp_df$name[i]<-paste(temp_df$name[i],id,sep="")
      id<-""
    }
    temp_df$name[i]<-paste(temp_df$name[i],id,sep="")
  }
  final_df<-temp_df
  
  #For all other n-1 games
  for (entries in (2:length(results))){ #Do the same for all other N-1 games 
    #Cleanup & Table values for A SINGLE GAME 
    data_raw <- results[[entries]]
    names <- enframe(unlist(data_raw))
    temp_df <- data.frame(names)
    temp_df <- temp_df[!grepl("tags|screenshots|store|image|requirements", temp_df$name),]
    
    for (i in 1:length(temp_df$name)){
      if (temp_df$name[i] %in% uniquify_list){
        id <- temp_df[i,"value"]
      }else if (temp_df$name[i] %in% stop_list){
        temp_df$name[i]<-paste(temp_df$name[i],id,sep="")
        id<-""
      }
      temp_df$name[i]<-paste(temp_df$name[i],id,sep="")
    }
    final_df<-full_join(final_df, temp_df, by = "name") #Joining by 'name' column
  }
  
  #Cleaning up Data.frame
  final_df<-t(final_df)
  colnames(final_df) <- final_df[1,]
  final_df<-final_df[-1,]
  rownames(final_df)<-NULL
  
  #Return object
  return(final_df)
}