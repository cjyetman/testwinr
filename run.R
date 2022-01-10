rds_or_rda <- function(filepaths) {
   filepaths <- simplify_if_one_col_df(filepaths)
   stopifnot("`filepaths` must be a character vector" = typeof(filepaths) == "character")
   filepaths <- canonize_path(filepaths)

   vapply(
     X = filepaths,
     FUN = function(filepath) {
       if (is_file_accessible(filepath)) {
         con <- gzfile(filepath, open = "rb")
         on.exit(close(con))

         hdr <- readBin(con, what = "raw", n = 5L)
         hdr_char <- paste(rawToChar(hdr, multiple = TRUE), collapse = "")

         if (grepl("^RD[ABX][2-9]\n", hdr_char)) {
           return("rda")
         } else if (grepl("^[AX]\n", hdr_char)) {
           return("rds")
         }
       }

       NA_character_
     },
     FUN.VALUE = character(1L),
     USE.NAMES = FALSE
   )
 }

rds_ascii <- tempfile()
obj <- "xyz"
saveRDS(obj, file = rds_ascii, ascii = TRUE, compress = FALSE)
rds_or_rda(rds_ascii)
