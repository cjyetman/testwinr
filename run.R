rds_ascii <- tempfile()
obj <- "xyz"
saveRDS(obj, file = rds_ascii, ascii = TRUE, compress = FALSE)

file.exists(rds_ascii)

con <- gzfile(rds_ascii, open = "rb")
on.exit(close(con))

hdr <- readBin(con, what = "raw", n = 5L)
hdr_char <- paste(rawToChar(hdr, multiple = TRUE), collapse = "")

grepl("^RD[ABX][2-9]\n", hdr_char)
grepl("^[AX]\n", hdr_char)

hdr
hdr_char
