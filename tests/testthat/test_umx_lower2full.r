# library(testthat)
# library(umx)
# test_file("~/bin/umx/tests/testthat/test_umx_lower2full.r") 
# 
# test_package("umx")

test_that("testing umx_lower2full", {
	# 1. Test with a vector in byrow = TRUE order), with diag
	tmp = c(
		1.0000, 
		0.6247, 1.0000,
		0.3269, 0.3669, 1.0000,
		0.4216, 0.3275, 0.6404, 1.0000,
		0.2137, 0.2742, 0.1124, 0.0839, 1.0000,
		0.4105, 0.4043, 0.2903, 0.2598, 0.1839, 1.0000,
		0.3240, 0.4047, 0.3054, 0.2786, 0.0489, 0.2220, 1.0000,
		0.2930, 0.2407, 0.4105, 0.3607, 0.0186, 0.1861, 0.2707,  1.0000,
		0.2995, 0.2863, 0.5191, 0.5007, 0.0782, 0.3355, 0.2302,  0.2950, 1.0000,
		0.0760, 0.0702, 0.2784, 0.1988, 0.1147, 0.1021, 0.0931, -0.0438, 0.2087, 1.000
	)
	expect_warning(umx_lower2full(tmp, diag = TRUE), NA) # NA = no warning
	x = umx_lower2full(tmp, diag = TRUE)
	expect_true(isSymmetric(x), TRUE)

	# 3. Test with lower-vector, no diagonal.
	tmp = c(
		0.6247,
		0.3269, 0.3669,
		0.4216, 0.3275, 0.6404,
		0.2137, 0.2742, 0.1124, 0.0839,
		0.4105, 0.4043, 0.2903, 0.2598, 0.1839,
		0.3240, 0.4047, 0.3054, 0.2786, 0.0489, 0.2220,
		0.2930, 0.2407, 0.4105, 0.3607, 0.0186, 0.1861, 0.2707, 
		0.2995, 0.2863, 0.5191, 0.5007, 0.0782, 0.3355, 0.2302,  0.2950,
		0.0760, 0.0702, 0.2784, 0.1988, 0.1147, 0.1021, 0.0931, -0.0438, 0.2087
	)
	expect_warning(umx_lower2full(tmp, diag = FALSE), NA) # NA = no warning
	x = umx_lower2full(tmp, diag = FALSE)
	expect_true(isSymmetric(x), TRUE)
	
	# test byrow = FALSE
	tmp = c(
	1, -.17, -.22, -.19, -.12, .81, -.02, -.26, -.2, -.15,
	1,  .11,  .20,  .21, -.01,  70,  .10,  .17, .22,
	1,  .52,  .68, -.12,  .09, .49,  .27,  .46,
	1,   .5, -.06,  .17,  .26, .80,  .31,
	1,  -.1,  .19,  .36,  .23, .42,
	1,  .02,  -19, -.06, -.06,
	1,   .1,  .18,  .27,
	1,  .51,   .7,
	1,  .55,
	1)
	expect_warning(umx_lower2full(tmp, byrow = FALSE, diag = TRUE), NA) # NA = no warning
	x = umx_lower2full(tmp, byrow = FALSE, diag = TRUE)
	expect_true(isSymmetric(x), TRUE)

	tmp = c(
	-.17, -.22, -.19, -.12, .81, -.02, -.26, -.20, -.15,
	 .11,  .20,  .21, -.01, .70,  .10,  .17, .22,
	 .52,  .68, -.12,  .09, .49,  .27,  .46,
	 .50, -.06,  .17,  .26, .80,  .31,
	-.10,  .19,  .36,  .23, .42,
	 .02, -.19, -.06, -.06,
	 .10,  .18,  .27,
	 .51,  .70,
	 .55
	)
	expect_warning(umx_lower2full(tmp, byrow = FALSE, diag = FALSE), NA) # NA = no warning
	x = umx_lower2full(tmp, byrow = FALSE, diag = FALSE)
	expect_true(isSymmetric(x), TRUE)

	# 2. Test with matrix input
	tmpn = c("ROccAsp", "REdAsp", "FOccAsp", "FEdAsp", "RParAsp", 
	         "RIQ", "RSES", "FSES", "FIQ", "FParAsp")
	tmp = matrix(nrow = 10, ncol = 10, byrow = TRUE, dimnames = list(tmpn,tmpn), data = 
		c(1.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000,  0.0000, 0.0000, 0,
		0.6247, 1.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000,  0.0000, 0.0000, 0,
		0.3269, 0.3669, 1.0000, 0.0000, 0.0000, 0.0000, 0.0000,  0.0000, 0.0000, 0,
		0.4216, 0.3275, 0.6404, 1.0000, 0.0000, 0.0000, 0.0000,  0.0000, 0.0000, 0,
		0.2137, 0.2742, 0.1124, 0.0839, 1.0000, 0.0000, 0.0000,  0.0000, 0.0000, 0,
		0.4105, 0.4043, 0.2903, 0.2598, 0.1839, 1.0000, 0.0000,  0.0000, 0.0000, 0,
		0.3240, 0.4047, 0.3054, 0.2786, 0.0489, 0.2220, 1.0000,  0.0000, 0.0000, 0,
		0.2930, 0.2407, 0.4105, 0.3607, 0.0186, 0.1861, 0.2707,  1.0000, 0.0000, 0,
		0.2995, 0.2863, 0.5191, 0.5007, 0.0782, 0.3355, 0.2302,  0.2950, 1.0000, 0,
		0.0760, 0.0702, 0.2784, 0.1988, 0.1147, 0.1021, 0.0931, -0.0438, 0.2087, 1)
	)

	expect_warning(umx_lower2full(tmp, diag = TRUE), NA) # NA = no warning
	x = umx_lower2full(tmp, diag = TRUE)
	expect_true(isSymmetric(x), TRUE)
	

	# Diagonal in the wrong place should give warning
	tmp = c(
		1, 0.6247,
		1, 0.3269, 0.3669,
		1, 0.4216, 0.3275, 0.6404,
		1, 0.2137, 0.2742, 0.1124, 0.0839,
		1, 0.4105, 0.4043, 0.2903, 0.2598, 0.1839,
		1, 0.3240, 0.4047, 0.3054, 0.2786, 0.0489, 0.2220,
		1, 0.2930, 0.2407, 0.4105, 0.3607, 0.0186, 0.1861, 0.2707, 
		1, 0.2995, 0.2863, 0.5191, 0.5007, 0.0782, 0.3355, 0.2302,  0.2950,
		1, 0.0760, 0.0702, 0.2784, 0.1988, 0.1147, 0.1021, 0.0931, -0.0438, 0.2087
	)
	expect_warning(umx_lower2full(tmp, diag = TRUE))
	
	
})
