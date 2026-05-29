#' xclim: Bioclimatic Variables from Monthly Climate Data
#'
#' Computes the 19 standard bioclimatic variables (BIO01-BIO19) from monthly
#' climate data following the WorldClim specification. This is an R
#' implementation of the xbioclim C++ library, with a compiled C++ back-end
#' exposed through Rcpp.
#'
#' @section Main functions:
#' \describe{
#'   \item{\code{\link{bioclim}}}{Compute all 19 bioclimatic variables from
#'     monthly vectors (single pixel).}
#'   \item{\code{\link{bio01}} -- \code{\link{bio19}}}{Individual variable
#'     functions.}
#'   \item{\code{\link{bioclim_raster}}}{Block-based processing of
#'     \code{terra::SpatRaster} objects.}
#'   \item{\code{\link{era5_to_monthly}}}{ERA5-Land hourly to monthly
#'     aggregation.}
#'   \item{\code{\link{era5_bioclim}}}{End-to-end ERA5 to bioclim pipeline.}
#' }
#'
#' @docType package
#' @name xclim-package
#' @useDynLib xclim, .registration = TRUE
#' @import methods
#' @importFrom Rcpp evalCpp
"_PACKAGE"
