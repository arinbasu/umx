% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/build_run_modify.r
\name{umxRAM}
\alias{umxRAM}
\title{Easy-to-use RAM model maker.}
\usage{
umxRAM(model = NA, ..., data = NULL, name = NA, comparison = TRUE,
  setValues = TRUE, suffix = "", independent = NA,
  remove_unused_manifests = TRUE, showEstimates = c("none", "raw", "std",
  "both", "list of column names"), refModels = NULL,
  thresholds = c("deviationBased", "direct", "ignore", "left_censored"),
  autoRun = getOption("umx_auto_run"), optimizer = NULL, verbose = FALSE)
}
\arguments{
\item{model}{A model to update (or set to string to use as name for new model)}

\item{...}{mx or umxPaths, mxThreshold objects, etc.}

\item{data}{data for the model. Can be an \code{\link{mxData}} or a data.frame}

\item{name}{A friendly name for the model}

\item{comparison}{Compare the new model to the old (if updating an existing model: default = TRUE)}

\item{setValues}{Whether to generate likely good start values (Defaults to TRUE)}

\item{suffix}{String to append to each label (useful if model will be used in a multi-group model)}

\item{independent}{Whether the model is independent (default = NA)}

\item{remove_unused_manifests}{Whether to remove variables in the data to which no path makes reference (defaults to TRUE)}

\item{showEstimates}{Whether to show estimates. Defaults to no (alternatives = "raw", "std", etc.)}

\item{refModels}{pass in reference models if available. Use FALSE to suppress computing these if not provided.}

\item{thresholds}{Whether to use deviation-based threshold modeling for ordinal data (if any is detected), direct, or do nothing.}

\item{autoRun}{Whether to mxRun the model (default TRUE: the estimated model will be returned)}

\item{optimizer}{optionally set the optimizer (default NULL does nothing)}

\item{verbose}{Whether to tell the user what latents and manifests were created etc. (Default = FALSE)}
}
\value{
- \code{\link{mxModel}}
}
\description{
umxRAM expedites creation of RAM models, still without doing invisible things to the model.
}
\details{
Like \code{\link{mxModel}}, you list the theoretical causal paths. Unlike mxModel:
\enumerate{
\item{You don't need to set type = "RAM"}
\item{You don't need to list manifestVars (they are detected from path usage)}
\item{You don't need to list latentVars (detected as anything in paths but not in \code{mxData})}
\item{You add data like you do in \code{\link{lm}}, with \strong{data = }}
\item{with \code{\link{umxPath}} you can use powerful verbs like \strong{var = }}
\item{You don't need to add labels: paths are automatically labelled "a_to_b" etc.}
\item{You don't need to set start values, they will be done for you.}
\item{You don't need to mxRun the model: it will run automatically, and print a summary}
}

umxRAM is like lm, ggplot2 etc.: you give the data in a data = parameter
A common error is to include data in the main list, a bit like
saying lm(y ~ x + df) instead of lm(y ~ x, data = dd).

\strong{nb}: unlike mxModel, umxRAM needs data at build time.

If you are at the "sketching" stage of theory consideration, umxRAM supports
a simple vector of manifest names to work with.


\strong{Comparison with other software}

Some software has massive behind-the-scenes defaulting and path addition. I've played with 
similar features (like auto-creating error and exogenous variances using \code{endog.variances = TRUE}
and \code{exog.variances = TRUE}). Also identification helpers like \code{fix = "latents"} 
and \code{fix = "firstLoadings"}.

To be honest, these are not only more trouble than they are worth, they encourage errors and 
poor modeling. I suggest user learn the handful of \code{\link{umxPath}}
short cuts and stay clean and explicit!
}
\examples{

# ===========================
# = Here's a simple example =
# ===========================
m1 = umxRAM("tim", data = mtcars,
	umxPath(c("wt", "disp"), to = "mpg"),
	umxPath("wt", with = "disp"),
	umxPath(v.m. = c("wt", "disp", "mpg"))
)
plot(m1, std=TRUE, means=FALSE)

# ====================================
# = A cov model, with steps laid out =
# ====================================

# 1. For convenience, list up the manifests you will be using
selVars = c("mpg", "wt", "disp")

# 2. Create an mxData object
myCov = mxData(cov(mtcars[,selVars]), type = "cov", numObs = nrow(mtcars) )

# 3. Create the model (see ?umxPath for more nifty options)
m1 = umxRAM("tim", data = myCov,
	umxPath(c("wt", "disp"), to = "mpg"),
	umxPath("wt", with = "disp"),
	umxPath(var = selVars)
)

# 4. Use umxSummary to get standardized parameters, CIs etc.
umxSummary(m1, show = "std")

# 5. Display path diagram
plot(m1)
plot(m1, std = TRUE, resid = "line")

# ===============================
# = Using umxRAM in Sketch mode =
# ===============================
# No data needed: just list variable names!
# Resulting model will be plotted automatically
m1 = umxRAM("what does unique pairs do, I wonder", data = c("B", "C"),
# B<->B, C<->C, B<->C
umxPath(unique.pairs = c("B", "C"))
)

m1 = umxRAM("ring around the rosey", data = c("B", "C"),
# A->B, A->C, B->A, B->C, C->A, C->B
umxPath(fromEach = c("A", "B", "C"))
)

m1 = umxRAM("fromEach with to", data = c("B", "C"),
# B->D, C->D
umxPath(fromEach = c("B", "C"), to= "D")
)

m1 = umxRAM("CFA_play", data = paste0("x", 1:4),
	umxPath("g", to = paste0("x", 1:4)),
	umxPath(var = paste0("x", 1:4)),
	umxPath(v1m0 = "g")
)

# =================================================
# = This is an example of using your own labels:  =
#   umxRAM will not over-ride them                =
# =================================================
m1 = umxRAM("tim", data = myCov,
	umxPath(c("wt", "disp"), to = "mpg"),
	umxPath(cov = c("wt", "disp"), labels = "b1"),
	umxPath(var = c("wt", "disp", "mpg"))
)
omxCheckEquals(m1$S$labels["disp", "wt"], "b1") # label preserved
m1$S$labels
#      mpg             wt            disp
# mpg  "mpg_with_mpg"  "mpg_with_wt" "disp_with_mpg"
# wt   "mpg_with_wt"   "wt_with_wt"  "b1"
# disp "disp_with_mpg" "b1"          "disp_with_disp"
}
\references{
- \url{http://tbates.github.io}, \url{https://github.com/tbates/umx}
}
\seealso{
\code{\link{umxPath}}, \code{\link{umxSummary}}, \code{\link{plot}}, \code{\link{parameters}}, \code{\link{umxSuperModel}}

Other Core Modelling Functions: \code{\link{plot.MxModel}},
  \code{\link{umxAlgebra}}, \code{\link{umxMatrix}},
  \code{\link{umxPath}}, \code{\link{umxRun}},
  \code{\link{umxSuperModel}}, \code{\link{umx}}
}
