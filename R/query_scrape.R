query_scrape <- function(start, end, query, granularity=60*60*24) {

  #initial setup for the scraper, takes in start and end times, query, and time interval

  t1 <- as.POSIXct(as.Date(start, format = "%Y-%m-%d")) |>
    as.integer() #set the start time of the scrape, in UTC format

  t2 <- as.POSIXct(as.Date(end, format = "%Y-%m-%d")) |>
    as.integer() #set the end time of the scrape, in UTC format

  times <- seq(t1, t2, by = granularity) #time interval of the scraper, with 6hr windows

  output <- data.frame(
    matrix(ncol = 11,
           nrow = 0)
  ) |>
    rename(
      author = 1,
      created_utc = 2,
      id = 3,
      num_comments = 4,
      permalink = 5,
      score = 6,
      subreddit = 7,
      subreddit_id = 8,
      title = 9,
      selftext = 10
    )

  # function that reads API-output JSON for each time interval, and outputs
  # a dataframe with the relevant information for each post

  # **next step:** check if scrape >100 posts, if so then go granular

  for (i in 1:(length(times)-1)){

    since = times[i] #set the start time of the scrape, in UTC format
    until = times[i+1] #set the end time of the scrape, in UTC format

    tempdata <- read_json(
      paste0("https://api.pullpush.io/reddit/submission/search?html_decode=True&since=",
             format(since, scientific = F),
             "&until=",
             format(until, scientific = F),
             "&q=",
             query,
             "&size=100"),
      simplifyVector = TRUE) #read in the JSON from the API

    Sys.sleep(0.5) # rate limit fixer; documentation is unclear

    if (length(tempdata$data) == 0){ #if there are no posts in the time interval, skip
      next
    } else{

      output <- rbind(output, tempdata$data |>
                        select(
                          c(
                            author, #author of the post
                            created_utc, #time of creation, UTC format
                            id, #unique 6-7 digit code for IDing posts
                            num_comments, #number of comments
                            permalink, #link to the post
                            score, #likes - dislikes; overall score of the post
                            subreddit, #subreddit name
                            subreddit_id, #unique 6-7 digit code for IDing subreddits
                            title, #title of the post
                            selftext #text of the post
                          )
                        )
      )
    }

  }

  output

}
