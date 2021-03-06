% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_and_utility.r
\name{umx_cov2raw}
\alias{umx_cov2raw}
\title{Turn a cov matrix into raw data with umx_cov2raw}
\usage{
umx_cov2raw(myCovariance, n, means = 0)
}
\arguments{
\item{myCovariance}{a covariance matrix}

\item{n}{how many rows of data to return}

\item{means}{the means of the raw data (defaults to 0)}
}
\value{
- data.frame
}
\description{
Turns a covariance matrix into comparable raw data :-)
}
\examples{
covData <- matrix(nrow=6, ncol=6, byrow=TRUE, dimnames=list(paste0("v", 1:6), paste0("v", 1:6)),
data = c(0.9223099, 0.1862938, 0.4374359, 0.8959973, 0.9928430, 0.5320662,
           0.1862938, 0.2889364, 0.3927790, 0.3321639, 0.3371594, 0.4476898,
           0.4374359, 0.3927790, 1.0069552, 0.6918755, 0.7482155, 0.9013952,
           0.8959973, 0.3321639, 0.6918755, 1.8059956, 1.6142005, 0.8040448,
           0.9928430, 0.3371594, 0.7482155, 1.6142005, 1.9223567, 0.8777786,
           0.5320662, 0.4476898, 0.9013952, 0.8040448, 0.8777786, 1.3997558))
myData = umx_cov2raw(covData, n = 100, means = 1:6)
}
\references{
- \url{http://tbates.github.io}, \url{https://github.com/tbates/umx}
}
\seealso{
- \code{\link{cov2cor}}

Other Data Functions: \code{\link{umxCovData}},
  \code{\link{umxHetCor}},
  \code{\link{umxPadAndPruneForDefVars}},
  \code{\link{umx_as_numeric}},
  \code{\link{umx_lower2full}},
  \code{\link{umx_make_MR_data}},
  \code{\link{umx_make_bin_cont_pair_data}},
  \code{\link{umx_make_fake_data}},
  \code{\link{umx_polychoric}},
  \code{\link{umx_polypairwise}},
  \code{\link{umx_polytriowise}},
  \code{\link{umx_read_lower}}, \code{\link{umx_rename}},
  \code{\link{umx_reorder}}, \code{\link{umx_stack}},
  \code{\link{umx_swap_a_block}}, \code{\link{umx}}
}
