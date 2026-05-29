# xclim 0.1.0

* Initial CRAN submission.
* Compute all 19 standard bioclimatic variables (BIO01–BIO19) from monthly
  climate data following the WorldClim specification.
* Single-pixel vector interface (`bioclim()`, `bio01()`–`bio19()`).
* Block-based raster processing via `bioclim_raster()` for memory-efficient
  handling of large `terra::SpatRaster` datasets.
* ERA5-Land hourly-to-monthly aggregation pipeline (`era5_to_monthly()`,
  `era5_t2m_to_monthly()`, `era5_tp_to_monthly()`).
* End-to-end ERA5 to bioclim pipeline (`era5_bioclim()`).
* C++17 backend with xtensor for high-performance array operations.
* OpenMP parallelism for multi-core processing.
