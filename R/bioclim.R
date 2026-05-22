#' Compute Bioclimatic Variables from Monthly Climate Data
#'
#' @description
#' Computes the 19 standard bioclimatic variables (BIO01-BIO19) from monthly
#' climate data following the WorldClim specification. This is an R
#' implementation of the xbioclim C++ library.
#'
#' @details
#' The 19 bioclimatic variables are:
#' \itemize{
#'   \item BIO01: Mean Annual Temperature
#'   \item BIO02: Mean Diurnal Range (mean of monthly (tasmax - tasmin))
#'   \item BIO03: Isothermality (100 * BIO02 / BIO07)
#'   \item BIO04: Temperature Seasonality (100 * population SD of monthly tas)
#'   \item BIO05: Max Temperature of Warmest Month
#'   \item BIO06: Min Temperature of Coldest Month
#'   \item BIO07: Temperature Annual Range (BIO05 - BIO06)
#'   \item BIO08: Mean Temperature of Wettest Quarter
#'   \item BIO09: Mean Temperature of Driest Quarter
#'   \item BIO10: Mean Temperature of Warmest Quarter
#'   \item BIO11: Mean Temperature of Coldest Quarter
#'   \item BIO12: Annual Precipitation
#'   \item BIO13: Precipitation of Wettest Month
#'   \item BIO14: Precipitation of Driest Month
#'   \item BIO15: Precipitation Seasonality (CV)
#'   \item BIO16: Precipitation of Wettest Quarter
#'   \item BIO17: Precipitation of Driest Quarter
#'   \item BIO18: Precipitation of Warmest Quarter
#'   \item BIO19: Precipitation of Coldest Quarter
#' }
#'
#' All functions accept either plain numeric vectors of length 12 (single
#' pixel) or a [BioclimData-class] object holding a raster block (multiple
#' pixels).  When a [BioclimData-class] object is supplied, computation is
#' delegated to the compiled C++ backend (xbioclim) and a numeric vector
#' (one value per pixel) is returned.
#'
#' @param tas    Numeric vector of length 12 **or** [BioclimData-class]:
#'   monthly mean temperature.
#' @param tasmax Numeric vector of length 12: monthly maximum temperature.
#' @param tasmin Numeric vector of length 12: monthly minimum temperature.
#' @param pr     Numeric vector of length 12: monthly precipitation.
#' @param ...    Currently unused; reserved for future extensions.
#'
#' @return
#' * For `bio01`–`bio19` with plain numeric-vector inputs: a single numeric
#'   value.
#' * For `bioclim()` with plain numeric-vector inputs: a named numeric vector
#'   of length 19 (names `bio01`–`bio19`).
#' * For [BioclimData-class] inputs to `bio01`–`bio19`: a numeric vector with
#'   one value per pixel.
#' * For [BioclimData-class] inputs to `bioclim()`: a numeric matrix with one
#'   row per pixel and 19 named columns (`bio01`–`bio19`).
#'
#' @examples
#' # Monthly climate data (12 values, one per month)
#' tas    <- c(5, 7, 10, 14, 18, 22, 25, 24, 20, 15, 10, 6)
#' tasmax <- c(8, 10, 14, 18, 23, 28, 32, 31, 26, 19, 13, 9)
#' tasmin <- c(1, 3, 6, 10, 13, 17, 20, 19, 15, 10, 6, 2)
#' pr     <- c(60, 55, 50, 40, 30, 15, 5, 10, 25, 45, 55, 65)
#'
#' # Compute all 19 bioclimatic variables at once
#' result <- bioclim(tas, tasmax, tasmin, pr)
#' print(result)
#'
#' # Compute individual variables
#' bio01(tas)           # Mean Annual Temperature
#' bio02(tasmax, tasmin) # Mean Diurnal Range
#' bio04(tas)           # Temperature Seasonality
#' bio12(pr)            # Annual Precipitation
#' bio15(pr)            # Precipitation Seasonality
#'
#' @name bioclim-variables
#' @aliases bio01 bio02 bio03 bio04 bio05 bio06 bio07 bio08 bio09 bio10
#'          bio11 bio12 bio13 bio14 bio15 bio16 bio17 bio18 bio19 bioclim
NULL

