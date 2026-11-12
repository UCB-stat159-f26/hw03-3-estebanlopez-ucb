#' Fetch career data from the tennis abstract website
#'
#' @param player_name A string of player names
#' @return A df that ready for plotting
#' @export
fetch_career_data <- function(player_name) {
  # ... function body ...
}

fetch_career_data <- function(player_name) {
  slug <- .format_player_slug(player_name)
  url <- paste0("https://www.tennisabstract.com/jsmatches/", slug, "Career.js")
  
  response <- tryCatch({
    readLines(url, warn = FALSE)
  }, error = function(e) {
    stop("Error fetching data for '", player_name, "'. Please check spelling or verify player exists.")
  })
  
  js_text <- paste(response, collapse = "\n")
  raw_mat <- .parse_tennis_js(js_text)
  
  if (length(raw_mat) == 0 || (is.matrix(raw_mat) && nrow(raw_mat) == 0)) {
    stop("No match data found for player: ", player_name)
  }
  
  df <- as.data.frame(raw_mat, stringsAsFactors = FALSE)
  
  if (ncol(df) >= 17 && nchar(df[1, 17]) == 8) {
    df$match_date <- as.Date(df[, 1], format = "%Y%m%d")
    df$player_age <- as.numeric(format(df$match_date, "%Y")) - as.numeric(substr(df[, 1], 1, 4))
    df$opp_birth <- as.Date(df[, 17], format = "%Y%m%d")
    df$opp_age <- as.numeric(difftime(df$match_date, df$opp_birth, units = "days")) / 365.25
  } else {
    df$player_age <- as.numeric(df[, 12])
    df$opp_age <- as.numeric(df[, 17])
  }
  
  cleaned_df <- data.frame(
    player_age = as.numeric(df$player_age),
    age_diff = as.numeric(df$player_age) - as.numeric(df$opp_age),
    result = ifelse(df[, 4] == "W", "Win", "Loss")
  )
  
  na.omit(cleaned_df)
}