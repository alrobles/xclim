# CRAN submission comments

## Test environments
- local: Ubuntu 20.04, R 4.1.2
- (planned) win-builder: R-devel
- (planned) R-hub: multiple platforms

## R CMD check results
0 errors | 0 warnings | 2 notes

### NOTEs

1. **New submission** — This is the first CRAN submission of `xclim`.

2. **Installed size is 8.2Mb** — The package bundles the `xtensor` and `xtl`
   C++ header-only libraries in `inst/include/` for high-performance array
   operations. These headers are required at compile time and cannot be reduced.

3. **DOI 10.1002/joc.1276 returns 403** — This is the canonical DOI for
   Hijmans et al. (2005) "Very high resolution interpolated climate surfaces
   for global land areas" (International Journal of Climatology). The DOI is
   valid but Wiley returns 403 to automated URL checkers.
