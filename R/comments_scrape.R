reddit_comments_scrape <- function(post_id) {

  # function that reads API-output JSON for each post ID with comments, and outputs
  # a dataframe with the relevant information for each comment

  try(

    read_json(
      paste0(
        "https://api.pullpush.io/reddit/search/comment/?link_id=",
        post_id
      ),
      simplifyVector = TRUE
    )[[1]] |>
      select(c(
        author, #author of the comment
        body, #text of the comment
        controversiality, #controversiality score of the comment
        created_utc, #time of creation, UTC format
        id, #unique 6-7 digit code for IDing comments
        score, #likes - dislikes; overall score of the comment
        subreddit #subreddit name
      )) |>
      mutate(
        post_id = post_id
      )

  )

}
