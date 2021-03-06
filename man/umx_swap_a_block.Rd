% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_and_utility.r
\name{umx_swap_a_block}
\alias{umx_swap_a_block}
\title{umx_swap_a_block}
\usage{
umx_swap_a_block(theData, rowSelector, T1Names, T2Names)
}
\arguments{
\item{theData}{a data frame to swap within}

\item{rowSelector}{rows to swap amongst columns}

\item{T1Names}{the first set of columns}

\item{T2Names}{the second set of columns}
}
\value{
- dataframe
}
\description{
Swap a block of rows of a dataset between two sets of variables (typically twin 1 and twin 2)
}
\examples{
test = data.frame(
a = paste0("a", 1:10),
b = paste0("b", 1:10),
c = paste0("c", 1:10),
d = paste0("d", 1:10), stringsAsFactors = FALSE)
umx_swap_a_block(test, rowSelector = c(1,2,3,6), T1Names = "b", T2Names = "c")
umx_swap_a_block(test, rowSelector = c(1,2,3,6), T1Names = c("a","c"), T2Names = c("b","d"))

}
\seealso{
- \code{\link{subset}}

Other Data Functions: \code{\link{umxCovData}},
  \code{\link{umxHetCor}},
  \code{\link{umxPadAndPruneForDefVars}},
  \code{\link{umx_as_numeric}}, \code{\link{umx_cov2raw}},
  \code{\link{umx_lower2full}},
  \code{\link{umx_make_MR_data}},
  \code{\link{umx_make_bin_cont_pair_data}},
  \code{\link{umx_make_fake_data}},
  \code{\link{umx_polychoric}},
  \code{\link{umx_polypairwise}},
  \code{\link{umx_polytriowise}},
  \code{\link{umx_read_lower}}, \code{\link{umx_rename}},
  \code{\link{umx_reorder}}, \code{\link{umx_stack}},
  \code{\link{umx}}
}
