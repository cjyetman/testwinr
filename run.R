is_binary <- function(filepath) {
  file_command <- Sys.which("file")
  if (fs::file_access(file_command, mode = "execute")) {
    system2(command = file_command, args = c("-b", "--mime-encoding", shQuote(filepath)), stdout = TRUE) == "binary"
  } else {
    sub("/.*$", "", wand::get_content_type(filepath)) == "binary"
  }
}

saveRDS("xxx", "xxx.rds")
is_binary("xxx.rds")
