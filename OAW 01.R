# Base URL of our API: https://api.openaccessbutton.org
# /metadata: finds as complete as possible metadata for any paper

library(httr)
library(jsonlite)

# specify the DOI
doi <- "10.1056/nejmoa2204233"

# make the API call and extract the response
response <- GET(paste0("https://api.openaccessbutton.org/metadata/", doi))
response_text <- content(response, "text")
metadata <- fromJSON(response_text)

# print the metadata
metadata

# write the metadata to a CSV file
write.csv(as.matrix(metadata), "metadata.csv", row.names = FALSE)

