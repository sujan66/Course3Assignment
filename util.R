#functions for reading and merging datasets

#takes file locations as arguments and returns merged tibbles(data frames)
merge_dataset <- function(x, y) {
  if (!file.exists(x) && !file.exists(y)) {
    print("Invalid file location")
    NULL
  } else
    tibble::as_tibble(rbind(read.table(x), read.table(y)))
}

#takes one file location as arguments and returns vector of names in column 2
extract_dataset <- function(x) {
  if (!file.exists(x)) {
    print("Invalid file location")
    NULL
  } else 
    as.vector(read.table(x)[, 2])
}