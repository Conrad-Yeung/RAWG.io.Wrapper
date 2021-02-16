library(docstring)
library(httr)
get_game_list <- function(n=40,page=1,api_key="",start_date="",end_date="",metacritic="",platform="",platform_count="",genre="",ordering=""){
  #' GET request to RAWG
  #'
  #' Submit RAWG query and receive RAWG response
  #'
  #' @importFrom httr GET
  #'
  #' @param n (int): number of games/entries (default = 40). Max 40. If you want to look at entries beyond the 40th index, use the `page` parameter.
  #' @param page (int): page number queried (default = 1) 
  #' @param api_key (str): your api key (recommended - not required, default = none)
  #' @param start_date (str): start release date in the form YYYY-MM-DD (default = none). Ex: "2020-01-30"
  #' @param end_date (str): end release date in the form YYYY-MM-DD (default = none). Ex: "2021-30-30"
  #' @param metacritic (str): metacritic rating range (default = none). Ex: "80,100" will give you ratings between 80 and 100.
  #' @param platforms (str):  ID of platform (1=XboxOne, 2=Playstation, 3=Xbox, 4=PC etc.) Ex: "1" or "1,2,3" for a range of platforms.  
  #' @param platform_count (int): number of platforms games are available on. 
  #' @param genre (str): the genre of games in the form of string or using the ID tag. Ex: "action,indie" or "4,51"
  #' @param ordering (str): how to order data, use "-" to reverse order. Ex: "name", "released", "created", "added", "updated", "rating", "-metacritic." 
  #'
  #' @return Large list containing response from RAWG query
  #'
  #' @examples get_game_list(start_date="2000-01-01",end_date="2020-12-31",genre="1,2,3",ordering ="-added")
  #' @examples get_game_list()
  
  #Check n <= 40
  if (n > 40){
    stop("Max query length is 40. If you want to get entries beyond the 40th game, please change the `page` number. For example, entry 41-80 use `page='2'.")
  } else {
    cleaned_n <- paste("page_size=",n,sep="")
  }
  
  #Page number
  cleaned_page<-paste("&page=",page,sep="")
  
  #Check if API Key is given
  if (api_key == ""){
    cleaned_api_key <- ""
  } else {
    cleaned_api_key <- paste("&key=",api_key,sep="")
  }
  
  #Check if dates are given
  if ((start_date == "")&(end_date=="")){ #No Dates Given
    cleaned_date <- ""
  }else if ((start_date != "") & (end_date=="")){ #Only Start Date Given
    stop("You need to enter an end date")
  }else if ((start_date == "") & (end_date!="")){
    stop("You need to enter an start date") #Only Start Date Given
  }else { #Both Dates given
    if ((grepl("[0-9]{4}-[0-9]{2}-[0-9]{2}",start_date) & grepl("[0-9]{4}-[0-9]{2}-[0-9]{2}",end_date)) == TRUE){
      if (start_date >= end_date){
        stop("start_date must be before end_date")
      }else{
        cleaned_date <- paste("&dates=",start_date,",",end_date,sep="")
      }
    } else {
      stop("Please enter dates in the form YYYY-MM-DD.")
    }
  }
  
  #Metacritic range
  if (metacritic == ""){
    cleaned_metacritic<-""
  }else{
    cleaned_metacritic <- paste("&metacritic=",metacritic,sep="") 
  }
  
  #Platforms
  if (platform == ""){
    cleaned_plat<-""
  }else{
    cleaned_plat <- paste("&platforms=",platform,sep="")
  }
  
  #Platform count 
  if (platform_count == ""){
    cleaned_plat_count<-""
  }else{
    cleaned_plat_count <- paste("&platforms_count=",platform_count,sep="")
  }
  
  #Genre
  if (genre == ""){
    cleaned_genre<-""
  }else{
    cleaned_genre <- paste("&genre=",genre,sep="")
  }
  
  #Ordering
  if (ordering == ""){
    cleaned_order <- "" 
  }else if (ordering %in% c("name","released","added","created","updated","rating","metacritic","-name","-released","-added","-created","-updated","-rating","-metacritic")){
    cleaned_order <- paste("&ordering=",ordering,sep="")
  }else{
    stop('Field must be one of the following: "name","released","added","created","updated","rating","metacritic","-name","-released","-added","-created","-updated","-rating","-metacritic"')
  }
  
  link <- paste("https://api.rawg.io/api/games?",cleaned_n,cleaned_page,cleaned_api_key,cleaned_metacritic,cleaned_date,cleaned_metacritic,cleaned_plat,cleaned_plat_count,cleaned_genre,cleaned_order,sep="")
  get_link <- GET(link)
  return(get_link)
}