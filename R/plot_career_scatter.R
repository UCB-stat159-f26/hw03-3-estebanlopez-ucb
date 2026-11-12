#' @param df A cleaned data frame from fetch_career_data()
#' @return A ggplot2 
#' @export
plot_career_scatter <- function(df) {
  ggplot2::ggplot(df, ggplot2::aes(x = player_age, y = age_diff, color = result)) +
    ggplot2::geom_point(alpha = 0.5, size = 1.2) +
    ggplot2::theme_minimal(base_size = 12) +
    ggplot2::labs(
      x = "Player's Age",
      y = "Age Difference (Player - Opponent)",
      color = "Match Outcome"
    ) +
    ggplot2::scale_color_manual(values = c("Win" = "#1a73e8", "Loss" = "#ea4335"))
}