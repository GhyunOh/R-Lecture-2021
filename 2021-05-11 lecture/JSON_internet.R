# Converting JSON to R DataFrame
library(jsonlite)

df_repos <- fromJSON("https://api.github.com/users/hadley/repos")

#Converting R DataFrame to JSON
json_repos <- toJSON(df_repos)