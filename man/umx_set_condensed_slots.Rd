% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_and_utility.r
\name{umx_set_condensed_slots}
\alias{umx_set_condensed_slots}
\title{umx_set_condensed_slots}
\usage{
umx_set_condensed_slots(state = NA)
}
\arguments{
\item{state}{what state (TRUE or FALSE) to set condensed slots (default NA returns current value).}
}
\value{
- current value of condensed slots
}
\description{
Sets whether newly-created mxMatrices are to be condensed (set to NULL if not being used) or not.
}
\examples{
library(umx)
old = umx_set_condensed_slots() # get the existing state
umx_set_condensed_slots(TRUE) # update globally
umx_set_condensed_slots(old) # set back
}
\references{
- \url{http://tbates.github.io}, \url{https://github.com/tbates/umx}
}
\seealso{
Other Get and set: \code{\link{umx_get_checkpoint}},
  \code{\link{umx_get_cores}},
  \code{\link{umx_get_optimizer}},
  \code{\link{umx_set_auto_plot}},
  \code{\link{umx_set_auto_run}},
  \code{\link{umx_set_checkpoint}},
  \code{\link{umx_set_cores}},
  \code{\link{umx_set_optimizer}},
  \code{\link{umx_set_plot_format}},
  \code{\link{umx_set_table_format}}
}
