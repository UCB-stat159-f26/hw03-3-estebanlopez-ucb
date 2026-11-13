#' Fetch and clean career data for a tennis player
#'
#' @param player_name Character string of the player's name
#' @return A cleaned data frame of match results
#' @export
fetch_career_data <- function(player_name) {
  slug <- .format_player_slug(player_name)
  url <- paste0("https://www.tennisabstract.com/jsmatches/", slug, "Career.js")
  
  js_text <- tryCatch({
    readLines(url, warn = FALSE)
  }, error = function(e) {
    stop("Error fetching data for '", player_name, "'. Please check spelling or verify player exists.")
  })
  
  js_combined <- paste(js_text, collapse = "\n")
  raw_list <- .parse_tennis_js(js_combined)
  .clean_match_df(raw_list)
}