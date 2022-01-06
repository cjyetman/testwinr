is_binary <- function(filepath) {
  file_command <- Sys.which("file")
  if (fs::file_access(file_command, mode = "execute")) {
    system2(command = file_command, args = c("-b", "--mime-encoding", shQuote(filepath)), stdout = TRUE) == "binary"
  } else {
    sub("/.*$", "", wand::get_content_type(filepath)) == "binary"
  }
}

saveRDS("xxx", "xxx.rds")
print(is_binary("xxx.rds"))
print(Sys.which("file"))
print(fs::file_access(Sys.which("file"), mode = "execute"))
print(system2(command = Sys.which("file"), args = c("-b", "--mime-encoding", shQuote("xxx.rds")), stdout = TRUE))
print(wand::get_content_type("xxx.rds"))


no_read_access <- "foo"
writeLines("XXX", no_read_access)
fs::file_info(no_read_access)$permissions
fs::file_access(no_read_access, mode = "read")

fs::file_chmod(no_read_access, "u-r+w")
fs::file_info(no_read_access)$permissions
fs::file_access(no_read_access, mode = "read")

fs::file_chmod(no_read_access, "u-rwx")
fs::file_info(no_read_access)$permissions
fs::file_access(no_read_access, mode = "read")


bar <- "bar"
fs::file_create(bar, mode = "000")
fs::file_info(bar)$permissions
fs::file_access(bar, mode = "read")
file.access(bar, mode = 4L)


bar2 <- "bar2"
fs::file_create(bar2)
fs::file_info(bar2)$permissions
fs::file_access(bar2, mode = "read")
fs::file_chmod(bar2, "000")
fs::file_info(bar2)$permissions
fs::file_access(bar2, mode = "read")
file.access(bar2, mode = 4L)
