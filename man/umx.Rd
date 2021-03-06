% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/build_run_modify.r
\docType{package}
\name{umx}
\alias{umx}
\alias{umx-package}
\title{Helper Functions for Structural Equation Modelling in OpenMx}
\description{
umx allows you to more easily build, run, modify, and report models using OpenMx
with code. The core functions are linked below under \strong{See Also}
}
\details{
The functions are organized into families: Have a read of these below, click to explore.

All the functions have explanatory examples, so use the help, even if you think it won't help :-)
Have a look, for example at \code{\link{umxRAM}}

Introductory working examples are below. You can run all demos with demo(umx)
When I have a vignette, it will be: vignette("umx", package = "umx")

There is a helpful blog at \url{http://tbates.github.io}

If you want the bleeding-edge version:

devtools::install_github("tbates/umx")
}
\examples{
require("umx")
data(demoOneFactor)
myData = mxData(cov(demoOneFactor), type = "cov", numObs = nrow(demoOneFactor))
latents = c("G")
manifests = names(demoOneFactor)
m1 <- umxRAM("One Factor", data = myData,
	umxPath(latents, to = manifests),
	umxPath(var = manifests),
	umxPath(var = latents  , fixedAt=1)
)

# umx added informative labels, created starting values, 
# Ran you model (if autoRun is on), and displayed a brief summary
# including a comparison if you modified a model...!

# Let's get some journal-ready fit information

umxSummary(m1) 
umxSummary(m1, show = "std") #also display parameter estimates 
# You can get the coefficients of an MxModel with coef(), just like for lm etc.
coef(m1)

# ==================
# = Model updating =
# ==================
# Can we set the loading of X5 on G to zero?
m2 = omxSetParameters(m1, labels = "G_to_x1", values = 0, free = FALSE, name = "no_g_on_X5")
m2 = mxRun(m2)
# Compare the two models
umxCompare(m1, m2)

# Use umxModify to do the same thing in 1-line
m2 = umxModify(m1, "G_to_x1", name = "no_effect_of_g_on_X5", comparison = TRUE)

# ========================
# = Confidence intervals =
# ========================

# umxSummary() will show these, but you can also use the confint() function
confint(m1) # OpenMx's SE-based confidence intervals
umxConfint(m1, parm = 'all', run = TRUE) # likelihood-based CIs

# And make a Figure in dot (.gv) format!
plot(m1, std = TRUE)

# If you just want the .dot code returned set file = NA
plot(m1, std = TRUE, file = NA)
}
\references{
- \url{http://www.github.com/tbates/umx}
}
\seealso{
Other Teaching and testing Functions: \code{\link{tmx_genotypic_effect}},
  \code{\link{tmx_is.identified}}

Other Core Modelling Functions: \code{\link{plot.MxModel}},
  \code{\link{umxAlgebra}}, \code{\link{umxMatrix}},
  \code{\link{umxPath}}, \code{\link{umxRAM}},
  \code{\link{umxRun}}, \code{\link{umxSuperModel}}

Other Reporting Functions: \code{\link{loadings.MxModel}},
  \code{\link{tmx_is.identified}}, \code{\link{umxAPA}},
  \code{\link{umxEval}}, \code{\link{umxFactorScores}},
  \code{\link{umxGetParameters}}, \code{\link{umxReduce}},
  \code{\link{umxSummary}}, \code{\link{umx_APA_model_CI}},
  \code{\link{umx_APA_pval}}, \code{\link{umx_aggregate}},
  \code{\link{umx_names}}, \code{\link{umx_parameters}},
  \code{\link{umx_print}},
  \code{\link{umx_show_fit_or_comparison}},
  \code{\link{umx_show}}, \code{\link{umx_time}}

Other Modify or Compare Models: \code{\link{umxAdd1}},
  \code{\link{umxDrop1}}, \code{\link{umxEquate}},
  \code{\link{umxFixAll}}, \code{\link{umxMI}},
  \code{\link{umxModify}}, \code{\link{umxSetParameters}},
  \code{\link{umxUnexplainedCausalNexus}}

Other Plotting functions: \code{\link{plot.MxModel}},
  \code{\link{umxPlotACEcov}}, \code{\link{umxPlotACEv}},
  \code{\link{umxPlotACE}}, \code{\link{umxPlotCP}},
  \code{\link{umxPlotGxE_biv}}, \code{\link{umxPlotGxE}},
  \code{\link{umxPlotIP}}, \code{\link{umxPlotSimplex}}

Other Super-easy helpers: \code{\link{umxEFA}},
  \code{\link{umxTwoStage}}

Other Twin Modeling Functions: \code{\link{umxACE_cov_fixed}},
  \code{\link{umxACEcov}}, \code{\link{umxACEv}},
  \code{\link{umxACE}}, \code{\link{umxCP}},
  \code{\link{umxGxE_biv}}, \code{\link{umxGxE_window}},
  \code{\link{umxGxE}}, \code{\link{umxIP}},
  \code{\link{umxSexLim}}, \code{\link{umxSimplex}},
  \code{\link{umxSummaryACEcov}},
  \code{\link{umxSummaryACEv}},
  \code{\link{umxSummaryACE}}, \code{\link{umxSummaryCP}},
  \code{\link{umxSummaryGxE_biv}},
  \code{\link{umxSummaryGxE}}, \code{\link{umxSummaryIP}},
  \code{\link{umxSummarySexLim}},
  \code{\link{umxSummarySimplex}},
  \code{\link{xmu_twin_check}}

Other Twin Reporting Functions: \code{\link{umxReduceACE}},
  \code{\link{umxReduceGxE}}

Other Twin Data functions: \code{\link{umx_long2wide}},
  \code{\link{umx_make_TwinData}},
  \code{\link{umx_residualize}},
  \code{\link{umx_scale_wide_twin_data}},
  \code{\link{umx_wide2long}}

Other Get and set: \code{\link{umx_default_option}},
  \code{\link{umx_get_checkpoint}},
  \code{\link{umx_get_options}},
  \code{\link{umx_set_auto_plot}},
  \code{\link{umx_set_auto_run}},
  \code{\link{umx_set_checkpoint}},
  \code{\link{umx_set_condensed_slots}},
  \code{\link{umx_set_cores}},
  \code{\link{umx_set_optimizer}},
  \code{\link{umx_set_plot_file_suffix}},
  \code{\link{umx_set_plot_format}},
  \code{\link{umx_set_table_format}}

Other Check or test: \code{\link{umx_check_names}},
  \code{\link{umx_is_class}}, \code{\link{umx_is_numeric}},
  \code{\link{xmu_twin_check}}

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
  \code{\link{umx_swap_a_block}}

Other File Functions: \code{\link{dl_from_dropbox}},
  \code{\link{umx_make_sql_from_excel}},
  \code{\link{umx_move_file}}, \code{\link{umx_open}},
  \code{\link{umx_rename_file}},
  \code{\link{umx_write_to_clipboard}}

Other String Functions: \code{\link{umx_explode_twin_names}},
  \code{\link{umx_explode}}, \code{\link{umx_grep}},
  \code{\link{umx_names}}, \code{\link{umx_object_as_str}},
  \code{\link{umx_paste_names}}, \code{\link{umx_rot}},
  \code{\link{umx_trim}},
  \code{\link{umx_write_to_clipboard}}

Other Miscellaneous Stats Helpers: \code{\link{reliability}},
  \code{\link{umxCov2cor}}, \code{\link{umxHetCor}},
  \code{\link{umx_apply}}, \code{\link{umx_cor}},
  \code{\link{umx_fun_mean_sd}}, \code{\link{umx_means}},
  \code{\link{umx_r_test}}, \code{\link{umx_round}},
  \code{\link{umx_var}}

Other Miscellaneous Utility Functions: \code{\link{install.OpenMx}},
  \code{\link{qm}}, \code{\link{umxBrownie}},
  \code{\link{umxFactor}}, \code{\link{umxVersion}},
  \code{\link{umx_array_shift}},
  \code{\link{umx_cont_2_quantiles}},
  \code{\link{umx_find_object}}, \code{\link{umx_make}},
  \code{\link{umx_msg}}, \code{\link{umx_open_CRAN_page}},
  \code{\link{umx_pad}}, \code{\link{umx_pb_note}},
  \code{\link{umx_print}}, \code{\link{umx_scale}}

Other datasets: \code{\link{GFF}}, \code{\link{iqdat}},
  \code{\link{us_skinfold_data}}

Other Advanced Model Building Functions: \code{\link{umxJiggle}},
  \code{\link{umxLabel}}, \code{\link{umxLatent}},
  \code{\link{umxRAM2Ordinal}},
  \code{\link{umxThresholdMatrix}},
  \code{\link{umxValues}}, \code{\link{umx_add_variances}},
  \code{\link{umx_fix_first_loadings}},
  \code{\link{umx_fix_latents}},
  \code{\link{umx_get_bracket_addresses}},
  \code{\link{umx_string_to_algebra}}

Other zAdvanced Helpers: \code{\link{umx_merge_CIs}},
  \code{\link{umx_standardize_ACEcov}},
  \code{\link{umx_standardize_ACEv}},
  \code{\link{umx_standardize_ACE}},
  \code{\link{umx_standardize_CP}},
  \code{\link{umx_standardize_IP}},
  \code{\link{umx_standardize_Simplex}},
  \code{\link{umx_stash_CIs}}

Other xmu internal not for end user: \code{\link{umxModel}},
  \code{\link{xmuHasSquareBrackets}},
  \code{\link{xmuLabel_MATRIX_Model}},
  \code{\link{xmuLabel_Matrix}},
  \code{\link{xmuLabel_RAM_Model}}, \code{\link{xmuMI}},
  \code{\link{xmuMakeDeviationThresholdsMatrices}},
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
