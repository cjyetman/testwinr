rds_ascii <- tempfile()
obj <- "xyz"
saveRDS(obj, file = rds_ascii, ascii = TRUE, compress = FALSE)
