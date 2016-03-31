# devtools::document("~/bin/umx"); devtools::install("~/bin/umx");
# ==================
# = Model Builders =
# ==================
#' umxEFA
#'
#' A helper for EFA that only requires you to choose how many factors and offer up manifest data.
#' This is very much early days. I will add "scores" if there is demand, but you are better off
#' making a CFA model and getting scores from that with \code{\link{mxFactorScores}}.
#' 
#' You can create an EFA either by specifying some factor names:
#' 
#' umxEFA(factors = c("g", "v"), data = mtcars)
#' 
#' or 
#' 
#' umxEFA(factors = 2, data = mtcars)
#'
#' \figure{umxEFA.png}
#' 
#' \emph{notes}: In an EFA, all items may load on all factors.
#' For identification we need m^2 degrees of freedom. We get m * (m+1)/2 from fixing factor variances to 1 and covariances to 0.
#' We get another m(m-1)/2 degrees of freemdom by fixing the upper-right hand corner of the factor loadings
#' component of the A matrix. The manifest variances are also lbounded at 0.
#' 
#' EFA reports standardized loadings: to do this, we scale the data.
#' 
#' Bear in mind that factor scores are indeterminate and can be rotated.
#' 
# todo: detect ordinal items and switch to UWLS
#' 
#' @param name A name for your model.
#' @param factors Either a number (of factors to request) or a list of factor names.
#' @param data A dataframe of manifest columns you are modeling
#' @param covmat Covariance matrix of data you are modeling
#' @param n.obs Number of observations in covmat (if provided, default = NA)
#' @param rotation A rotation to perform on the loadings (default  = "varimax")
#' @param digits rounding (defaults to 2)
#' @param report What to report
#' @return - \code{\link{mxModel}}
#' @family Super-easy helpers
#' @export
#' @seealso - \code{\link{factanal}}
#' @references - \url{http://github.com/tbates/umx}
#' @examples
#' myVars <- c("mpg", "disp", "hp", "wt", "qsec")
#' m1 = umxEFA(name = "named"    , factors = "g", data = mtcars[, myVars])
#' m2 = umxEFA(name = "by_number", factors =   2, rotation = "promax", data = mtcars[, myVars])
#' loadings(m2)
#' plot(m2)
#' m3 = factanal(~ mpg + disp + hp + wt + qsec, factors = 2, rotation = "promax", data = mtcars[])
umxEFA <- function(name = "efa", factors = NULL, data = NULL, covmat = NULL, n.obs = NULL, rotation = c("varimax", "promax", "none"), digits = 2, report = c("1", "table", "html")){
	# name     = "efa"
	# factors  = 1
	# data     = mtcars[,c("mpg", "disp", "hp", "wt", "qsec")]
	# rotation = "varimax"
	message("umxEFA is beta-only, and NOT ready for prime time")
	if(!is.null(covmat) ||!is.null(n.obs)){
		stop("Covmat support not yet implemented - but you may as well be using factanal...")
	}

	if(is.null(data)){
		stop("You need to provide data to factor analyse.")
	}
	# what about for scores? then we don't want std loadings...
	data = umx_scale(data)
	rotation = umx_default_option(rotation, c("varimax", "promax", "none"), check = FALSE)
	if(is.null(factors)){
		stop("You need to request at least 1 latent factor.")
	} else if( length(factors)==1 && class(factors)=="numeric"){
		factors = paste0("F", c(1:factors))
	}
	# TODO adapt to input datatype, i.e., add cov handler
	manifests <- names(data)
	m1 <- umxRAM(model = name, data = data, autoRun = FALSE,
		umxPath(factors, to = manifests, connect = "unique.bivariate"),
		umxPath(v.m. = manifests),
		umxPath(v1m0 = factors, fixedAt = 1)
	)
	# Fix upper-right triangle of A-matrix factor columns at zero
	nFac       = length(factors)
	nManifests = length(manifests)
	if(nFac > 1){
		for(i in 2:nFac){
			m1$A$free[1:(i-1), factors[i]] = FALSE
			m1$A$values[1:(i-1), factors[i]] = 0
		}
	}
	# lbound the manifest diagonal to avoid mirror indeterminacy
	for(i in seq_along(manifests)) {
	   thisManifest = manifests[i]
	   m1$A$lbound[thisManifest, thisManifest] = 0
	}
	m1 = mxRun(m1)
	if(rotation != "none" && nFac > 1){
		x = loadings(m1, verbose = F)
		x = eval(parse(text = paste0(rotation, "(x)")))
		m1$A$values[manifests, factors] = x$loadings[1:nManifests, 1:nFac]
		print(x)
	} else {
		print(loadings(m1))
	}
	umxSummary(m1, digits = digits, report = report);
	invisible(m1)
}