#' GET request to RAWG
#'
#' Submit RAWG query and receive RAWG response formatted as a data frame
#' 
#' @import httr
#' @import jsonlite
#' @import dplyr
#' @import tibble 
#' 
#' @param api_key (str): your api key (recommended - not required, default = none)
#' @param ordering (str): Which field to use when ordering the results("id", "added")
#' @param Page (int): A page number within the paginated result set.
#' @param Page_size (int): Number of results to return per page.
#'
#' @return Return Data.Frame with list of game platforms
#'
#' @export
#'
#' @examples 
#' key = "95731a37dcf84a638308f6f40fb01801"
#' p = 1
#' p_size = 5
#' ordering = "id"
#' df <- get_platform(key,Page = p, Page_size = p_size, ordering)

get_platform <- function(api_key = "", ordering="added", Page="", Page_size=""){
  #TODO: Check for insertion attacks
  if (TRUE %in% grepl("&|%",c(api_key, ordering, Page, Page_size))){
    stop("Please do not try to mess with the GET request.")
  }
  
  #TODO: clean variables and build the link:
  link = "https://api.rawg.io/api/platforms?"
  
  if(Page != ""){
    link=paste(link,Page,sep="&")
  }
  
  if(api_key != ""){
    link=paste(link,api_key,sep="&")
  }
  
  if(Page_size != ""){
    link = paste(link,Page_size,sep="")
  }
  
  if(ordering != ""){
    link = paste(link,ordering, sep = "&")
  }
  
  # #TODO: build url:
  # link <- paste("https://api.rawg.io/api/platforms?",cleaned_api_key, cleaned_ordering, cleaned_page, cleaned_page_size)
  
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
  df <- (raw_content$results)
  
  #TODO: dataframe wrangling
  id = c()
  Name = c()
  slug = c()
  count = c()
  image_b = c()
  year = c()
  games = c()
  
  for(i in 1:length(df)){
    id <- append(id,df[[i]]$id)
    Name <- append(Name,df[[i]]$name)
    slug <- append(slug, df[[i]]$slug)
    count <- append(count, df[[i]]$games_count)
    image_b <- append(image_b, df[[i]]$image_background)
    year <- append(year, paste(df[[i]]$year_start, df[[i]]$year_end, sep = "-"))
    
    game_list = df[[i]]$games[[1]]$name
    for(n in 2:length(df[[i]]$games)){
      game_list<-paste(game_list, df[[i]]$games[[n]]$name, sep = ", ")
    }
    
    games<-append(games, game_list)
  }
  
  
  df <- as.data.frame(cbind(id,Name,slug,count,image_b,year,games))
  
  
  df
}



