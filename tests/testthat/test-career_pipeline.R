test_that("string formatting helper creates PascalCase slugs", {
  expect_equal(.format_player_slug("Serena Williams"), "SerenaWilliams")
  expect_equal(.format_player_slug("Novak Djokovic"), "NovakDjokovic")
  expect_equal(.format_player_slug("  rafael-nadal 123 "), "RafaelNadal")
})

test_that("female and male fixtures parse and clean properly", {f_path <- test_path("fixtures", "FemalePlayerCareer.JS")
  m_path <- test_path("fixtures", "MalePlayerCareer.JS")

  f_js <- paste(readLines(f_path, warn = FALSE), collapse = "\n")
  m_js <- paste(readLines(m_path, warn = FALSE), collapse = "\n")

  f_df <- .clean_match_df(.parse_tennis_js(f_js))
  m_df <- .clean_match_df(.parse_tennis_js(m_js))

  expect_s3_class(f_df, "data.frame")
  expect_s3_class(m_df, "data.frame")
  expect_named(f_df, c("player_age", "age_diff", "result"))
  expect_named(m_df, c("player_age", "age_diff", "result"))
  expect_equal(nrow(f_df), 2)
  expect_equal(nrow(m_df), 2)
  expect_true(all(m_df$result %in% c("Win", "Loss")))})

test_that("plot_career_scatter returns a valid ggplot object", {
  sample_df <- data.frame(
    player_age = c(25.1, 26.4, 27.8),
    age_diff = c(2.3, -1.5, 4.0),
    result = c("Win", "Loss", "Win"))

  p <- plot_career_scatter(sample_df)
  expect_s3_class(p, "ggplot")})

test_that("fetch_career_data throws a clean error for invalid players", {
  expect_error(
    fetch_career_data("Nonexistent Tennis Player XYZ"),
    "Error fetching data for" )})