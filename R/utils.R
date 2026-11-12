.format_player_slug <- function(player_name) {
  cleaned <- gsub("[^a-zA-Z]", "", player_name)
  tools::toTitleCase(tolower(cleaned))}
.parse_tennis_js <- function(js_text) {
  json_string <- sub("^.*var morematchmx\\s*=\\s*", "", js_text)
  json_string <- sub(";?\\s*$", "", json_string)
  jsonlite::fromJSON(json_string)}
