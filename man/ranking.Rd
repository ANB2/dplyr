\name{ranking}
\alias{cume_dist}
\alias{dense_rank}
\alias{min_rank}
\alias{ntile}
\alias{percent_rank}
\alias{ranking}
\alias{row_number}
\title{Windowed rank functions.}
\usage{
row_number(x)

ntile(x, n)

min_rank(x)

dense_rank(x)

percent_rank(x)

cume_dist(x)
}
\arguments{
  \item{x}{a vector of values to rank}

  \item{n}{number of groups to split up into.}
}
\description{
Six variations on ranking functions, mimicing the ranking
functions described in SQL2003. They are currently
implemented using the built in \code{rank} function, and
are provided mainly as a convenience when converting
between R and SQL. All ranking functions map smallest
inputs to smallest outputs. Use \code{\link{desc}} to
reverse the direction..
}
\details{
\itemize{ \item \code{row_number}: equivalent to
\code{rank(ties.method = "first")} \item \code{min_rank}:
equivalent to \code{rank(ties.method = "min")} \item
\code{dense_rank}: like \code{min_rank}, but with no gaps
between ranks

\item \code{percent_rank}: a number between 0 and 1
computed by rescaling \code{min_rank} to [0, 1]

\item \code{cume_dist}: a cumulative distribution function.
Proportion of all values less than or equal to the current
rank.

\item \code{ntile}: a rough rank, which breaks the input
vector into \code{n} buckets.

}
}
\examples{
x <- c(5, 1, 3, 2, 2)
row_number(x)
min_rank(x)
dense_rank(x)
percent_rank(x)
cume_dist(x)

ntile(x, 2)
ntile(runif(100), 10)
}

