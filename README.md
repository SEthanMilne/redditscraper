# Reddit Scraper

------------------------------------------------------------------------

Scraping reddit has become much more difficult since the site went private and restricted their API. Other reddit scrapers using R exist, but typically 1) don't have access to full historical data or 2) require a premium reddit API key to scrape at any appreciable scale.

I wrote this small set of scripts to leverage the pullpush API, which uses massive torrented archives of reddit data to create an alternative to the Reddit API. The pullpush api docs can be found here: <https://pullpush.io>.

There are currently three basic functions in this package, that let users 1) search for posts by subreddit, 2) search for posts by query, and 3) download all comments associated with a given post. These can be time-bounded as well, so you can, for example, search for posts made about "Cars" after June 1st, 2022, or look for posts made in r/pics before January 2nd, 2018.

The pullpush API limits users to queries outputting 100 posts at a time, so there is an additional setting in the post-searching functions called `granularity` that gives you finer control over how much data you gather. Granularity is measured in seconds, so if you set granularity to 60\*60\*24, that will return 100 posts per day in your search.

------------------------------------------------------------------------

# Installation

You can install `redditscraper` with the following code:

```{r}
install.packages("devtools") # if you have not installed "devtools" package
devtools::install_github("SEthanMilne/redditscraper")
```

------------------------------------------------------------------------

# Citation

If you end up using this small package and want to cite me, here's a citation key:

```{r}
To cite package ‘redditscraper’ in publications use:

  Ethan Milne (2024). redditscraper. R package version
  0.1.0.

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {redditscraper},
    author = {Ethan Milne},
    year = {2024},
    note = {R package version 0.1.0},
  }

```
