# RawgioR

[![Build Status](https://travis-ci.com/Conrad-Yeung/RAWG.io.Wrapper.svg?branch=main)](https://travis-ci.com/Conrad-Yeung/RAWG.io.Wrapper)
[![R-CMD-check](https://github.com/Conrad-Yeung/Data534-Project-Group8/workflows/R-CMD-check/badge.svg)](https://github.com/Conrad-Yeung/Data534-Project-Group8/actions)


This project is an API wrapper for R around www.rawg.io - the largest video game database and game discovery service. It has over 350,000+ games, search, and machine learning recommendations for 50 platforms including mobiles. This package provides an easy to use interface in R language to find and transform information about the video games using rich metadata like tags, genres, developers, publishers, individual creators, official websites, release dates or Metacritic ratings.

Current list of functions included in the wrapper:
- get_game_list()
- get_genre_list()

We also plan to add support RAWG features like:
- 'Where to buy' giving links to digital distribution services, 
- Similar games based on visual similarity, and
- Player activity data like average playtime and RAWG player counts and ratings.


## Installation
### Install from Github
``` r
install.packages("devtools")
devtools::install_github("Conrad-Yeung/RAWG.io.Wrapper")
```


Loading
------------

To load the pacakge

``` r
library(RAWG.io.Wrapper)
```


## Examples
To make a basic call for a list of games with default parameters. Returns the data stored as a data.frame object.
```r
# To get more information on the function
?get_game_list

df <- get_game_list()
```
Check the [vignette](https://github.com/Conrad-Yeung/RAWG.io.Wrapper/blob/main/vignettes/Introduction.html) to see all functions in action.


## Code of Conduct
Please note that this project is released with a [Contributor Code of Conduct](https://github.com/Conrad-Yeung/RAWG.io.Wrapper/blob/main/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

