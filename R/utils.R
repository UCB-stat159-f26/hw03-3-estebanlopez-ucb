.format_player_slug <- function(player_name) {
  cleaned <- gsub("[^a-zA-Z]", "", player_name)
  tools::toTitleCase(tolower(cleaned))}
.parse_tennis_js <- function(js_text) {
  json_string <- sub("^.*var morematchmx\\s*=\\s*", "", js_text)
  json_string <- sub(";?\\s*$", "", json_string)
  jsonlite::fromJSON(json_string)}

.clean_match_df <- function(raw_mat) {
  df <- as.data.frame(raw_mat, stringsAsFactors = FALSE)
  is_female <- ncol(df) >= 17 && nchar(df[1, 17]) == 8
  p_age <- if (is_female) rep(NA_real_, nrow(df)) else as.numeric(df[, 12])
  if (is_female) {
    m_date <- as.Date(df[, 1], "%Y%m%d")
    p_age <- as.numeric(format(m_date, "%Y")) - as.numeric(substr(df[, 1], 1, 4))
    o_age <- as.numeric(difftime(m_date, as.Date(df[, 17], "%Y%m%d"), units = "days")) / 365.25
  } else {
    o_age <- as.numeric(df[, 17])}
  stats::na.omit(data.frame(
    player_age = p_age,
    age_diff = p_age - o_age,
    result = ifelse(df[, 4] == "W", "Win", "Loss")))}