\name{top_n}
\alias{top_n}
\title{Select top n rows (by value).}
\usage{
top_n(x, n, wt = NULL)
}
\arguments{
  \item{x}{a \code{\link{tbl}} to filter}

  \item{n}{number of rows to return. If \code{x} is
  grouped, this is the number of rows per group. May
  include more than \code{n} if there are ties.}

  \item{wt}{the variable to use for ordering. If not
  specified, defaults to the last varible in the tbl.}
}
\description{
This is a convenient wrapper that uses \code{\link{filter}}
and \code{\link{rank}} to select the top n entries in each
group, ordered by \code{wt}.
}
\examples{
if (require("Lahman")) {
  players <- group_by(tbl_df(Batting), playerID)
  games <- tally(players, G)
  top_n(games, 10, n)

  # A little nicer with \%.\%
  tbl_df(Batting) \%.\% group_by(playerID) \%.\% tally(G) \%.\% top_n(10)
}
}

