% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_builders.r
\name{umxFactorScores}
\alias{umxFactorScores}
\title{Return factor scores from a model as an easily consumable dataframe.}
\usage{
umxFactorScores(model, type = c("ML", "WeightedML", "Regression"),
  minManifests = NA)
}
\arguments{
\item{model}{The model to generate scores from.}

\item{type}{The method used to compute the score ('ML', 'WeightedML', or 'Regression').}

\item{minManifests}{The least number of variables required to return a score for a participant (Default = NA).}
}
\value{
- dataframe of scores.
}
\description{
umxFactorScores takes a model, and computes factors scores using the selected method (one 
of 'ML', 'WeightedML', or 'Regression')
It is a simple wrapper around mxFactorScores. For missing data, you must specify the least number of 
variables allowed for a score (subjects with fewer than minManifests will return a score of NA.
}
\examples{
m1 = umxEFA(mtcars, factors = 2)
x = umxFactorScores(m1, type = c('Regression'), minManifests = 3)
\dontrun{
m1 = umxEFA(mtcars, factors = 1)
x = umxFactorScores(m1, type = c('Regression'), minManifests = 3)
x
}
}
\references{
- \url{https://github.com/tbates/umx}, \url{https://tbates.github.io}
}
\seealso{
- \code{\link{mxFactorScores}}

Other Reporting Functions: \code{\link{loadings.MxModel}},
  \code{\link{tmx_is.identified}}, \code{\link{umxAPA}},
  \code{\link{umxEval}}, \code{\link{umxGetParameters}},
  \code{\link{umxReduce}}, \code{\link{umxSummary}},
  \code{\link{umx_APA_model_CI}},
  \code{\link{umx_APA_pval}}, \code{\link{umx_aggregate}},
  \code{\link{umx_names}}, \code{\link{umx_parameters}},
  \code{\link{umx_print}},
  \code{\link{umx_show_fit_or_comparison}},
  \code{\link{umx_show}}, \code{\link{umx_time}},
  \code{\link{umx}}
}
