% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/build_run_modify.r
\name{umxGxE}
\alias{umxGxE}
\title{umxGxE: Implements ACE models with moderation of paths, e.g. by SES.}
\usage{
umxGxE(name = "G_by_E", selDVs, selDefs, dzData, mzData, sep = NULL,
  lboundACE = NA, lboundM = NA, dropMissingDef = FALSE,
  autoRun = getOption("umx_auto_run"), optimizer = NULL)
}
\arguments{
\item{name}{The name of the model (defaults to "G_by_E")}

\item{selDVs}{The dependent variable (e.g. IQ)}

\item{selDefs}{The definition variable (e.g. socio economic status)}

\item{dzData}{The DZ dataframe containing the Twin 1 and Twin 2 DV and moderator (4 columns)}

\item{mzData}{The MZ dataframe containing the Twin 1 and Twin 2 DV and moderator (4 columns)}

\item{sep}{Expand variable base names, i.e., "_T" makes var -> var_T1 and var_T2}

\item{lboundACE}{= numeric: If !is.na, then lbound the main effects at this value (default = NA)}

\item{lboundM}{= numeric: If !is.na, then lbound the moderators at this value (default = NA)}

\item{dropMissingDef}{Whether to automatically drop missing def var rows for the user (gives a warning) default = FALSE}

\item{autoRun}{Whether to run the model, and return that (default), or just to create it and return without running.}

\item{optimizer}{optionally set the optimizer (default NULL does nothing)}
}
\value{
- GxE \code{\link{mxModel}}
}
\description{
Make a 2-group GxE (moderated ACE) model (Purcell, 2002). GxE interaction studies test the hypothesis that the strength
of genetic (or environmental) influence varies parametrically (usually linear effects on path estimates)
across levels of environment. umxGxE allows detecting,
testing, and visualizing  G xE (or C or E x E) interaction forms.
}
\details{
The following figure the GxE model as a path diagram:
\figure{GxE.png}
}
\examples{
require(umx)
data(twinData) 
twinData$age1 = twinData$age2 = twinData$age
selDVs  = "bmi"
selDefs = "age"
mzData  = subset(twinData, zygosity == "MZFF")[1:80,]
dzData  = subset(twinData, zygosity == "DZFF")[1:80,]
m1 = umxGxE(selDVs = "bmi", selDefs = "age", sep = "", 
	dzData = dzData, mzData = mzData, dropMissingDef = TRUE)
# Plot Moderation
umxSummaryGxE(m1)
umxSummary(m1, location = "topright")
umxSummary(m1, separateGraphs = FALSE)
m2 = umxModify(m1, "am_.*", regex=TRUE, comparison = TRUE)
\dontrun{
# The umxReduce function knows how to test all relevant hypotheses
# about model reduction for GxE models, reporting these in a nice table.
umxReduce(m1)
}
}
\references{
- Purcell, S. (2002). Variance components models for gene-environment interaction in twin analysis. \emph{Twin Research},
 \strong{6}, 554-571. DOI: https://doi.org/10.1375/twin.5.6.554
}
\seealso{
- \code{\link{plot}()}, \code{\link{umxSummary}}, \code{\link{umxReduce}}

Other Twin Modeling Functions: \code{\link{umxACE_cov_fixed}},
  \code{\link{umxACEcov}}, \code{\link{umxACEv}},
  \code{\link{umxACE}}, \code{\link{umxCP}},
  \code{\link{umxGxE_biv}}, \code{\link{umxGxE_window}},
  \code{\link{umxIP}}, \code{\link{umxSexLim}},
  \code{\link{umxSimplex}}, \code{\link{umxSummaryACEcov}},
  \code{\link{umxSummaryACEv}},
  \code{\link{umxSummaryACE}}, \code{\link{umxSummaryCP}},
  \code{\link{umxSummaryGxE_biv}},
  \code{\link{umxSummaryGxE}}, \code{\link{umxSummaryIP}},
  \code{\link{umxSummarySexLim}},
  \code{\link{umxSummarySimplex}}, \code{\link{umx}},
  \code{\link{xmu_twin_check}}
}
