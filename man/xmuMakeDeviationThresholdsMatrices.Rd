% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xmu.r
\name{xmuMakeDeviationThresholdsMatrices}
\alias{xmuMakeDeviationThresholdsMatrices}
\title{Make a deviation-based mxRAMObjective for ordinal models.}
\usage{
xmuMakeDeviationThresholdsMatrices(df, droplevels, verbose)
}
\arguments{
\item{df}{a dataframe}

\item{droplevels}{whether to droplevels or not}

\item{verbose}{how verbose to be}
}
\value{
- list of matrices
}
\description{
Purpose: return a mxRAMObjective(A = "A", S = "S", F = "F", M = "M", thresholds = "thresh"), mxData(df, type = "raw")
use-case see: umxMakeThresholdMatrix
}
\seealso{
Other xmu internal not for end user: \code{\link{umxModel}},
  \code{\link{umx}}, \code{\link{xmuHasSquareBrackets}},
  \code{\link{xmuLabel_MATRIX_Model}},
  \code{\link{xmuLabel_Matrix}},
  \code{\link{xmuLabel_RAM_Model}}, \code{\link{xmuMI}},
  \code{\link{xmuMakeOneHeadedPathsFromPathList}},
  \code{\link{xmuMakeTwoHeadedPathsFromPathList}},
  \code{\link{xmuMaxLevels}}, \code{\link{xmuMinLevels}},
  \code{\link{xmuPropagateLabels}},
  \code{\link{xmu_check_levels_identical}},
  \code{\link{xmu_dot_make_paths}},
  \code{\link{xmu_dot_make_residuals}},
  \code{\link{xmu_simplex_corner}},
  \code{\link{xmu_start_value_list}}
}
