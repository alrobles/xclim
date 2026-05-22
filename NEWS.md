# xclim 0.1.0

* Initial CRAN release.
* Compute the 19 standard bioclimatic variables (BIO01-BIO19) from monthly
  climate data following the WorldClim specification.
* Individual variable functions (`bio01()` through `bio19()`) and a unified
  `bioclim()` wrapper.
* S4 classes `BioclimData` and `BioclimModel` for structured input and
  C++-backed computation.
* `ClimateBlock` Rcpp module for batch processing of multi-pixel data.
* `bioclim_raster()` for memory-efficient block-based processing of
  `terra::SpatRaster` objects.
* `bioclim_engine()` for native GDAL-based tiled I/O pipeline (optional,
  requires GDAL >= 2.0.1).
* Optional CUDA GPU acceleration (requires CUDA toolkit >= 11.0).
* Four vignettes: getting-started, terra-comparison, benchmarking, and
  architecture.
