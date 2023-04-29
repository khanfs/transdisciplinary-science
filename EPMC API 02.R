# Search DOIs indexed on Europe PubMed Central from a CSV list of DOIs
# Raw output is unprocessed and unformatted metadata returned by the API
# Raw output necessary for fields not in the parsed metadata output


library(europepmc)
library(tidyr)
library(purrr)

# Read in the CSV file as a dataframe
df <- read.csv('/Users/farooqkhan/Documents/Data Science/OA APIs/Test_List.csv', stringsAsFactors = FALSE)

# Extract the DOIs as a vector
doi_vec <- df[,1]

# Query the Europe PMC API
results <- epmc_search_by_doi(doi_vec, output = 'raw')
head(results, 2)

# Evaluate data structure
is.list(results)
datastructure <-sapply(results, class)
datastructure

# Convert each element of the list to a data frame
results_df <- map_df(results, ~ {
  if (is.null(.x)) {
    # Return an NA value
    tibble(col = NA)
  } else if (is.data.frame(.x)) {
    .x
  } else {
    # Convert non-data-frame objects to a data frame with a single column
    tibble(col = .x)
  }
})

head(df_unnested, 2)

dim(df_unnested)

is.data.frame(df_unnested)

colnames(df_unnested)

View(df_unnested)

sapply(df_unnested, class)

df_unnested$col <- sapply(df_unnested$col, paste, collapse = "; ")

head(df_unnested, 5)

write.csv(df_unnested, file = '/Users/farooqkhan/Documents/Data Science/OA APIs/Unnested_List.csv', row.names = FALSE)

