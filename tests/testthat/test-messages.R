# Tests for the SpatMessages-style error/warning propagation system

# Helper: reset store before each test group
reset <- function() clear_messages()

# ── has_error / has_warning on empty store ──────────────────────────────────

test_that("store is empty at initialization", {
  reset()
  expect_false(has_error())
  expect_false(has_warning())
  expect_equal(bioclim_errors(),   character(0))
  expect_equal(bioclim_warnings(), character(0))
})

# ── push_error / bioclim_errors ──────────────────────────────────────────────

test_that("push_error stores a single error message", {
  reset()
  xclim:::push_error("something went wrong")
  expect_true(has_error())
  expect_equal(bioclim_errors(), "something went wrong")
})

test_that("push_error accumulates multiple errors", {
  reset()
  xclim:::push_error("first error")
  xclim:::push_error("second error")
  expect_equal(bioclim_errors(), c("first error", "second error"))
})

test_that("push_error rejects non-character input", {
  reset()
  expect_error(xclim:::push_error(42), "'msg' must be a character string")
})

test_that("push_error rejects vector input", {
  reset()
  expect_error(xclim:::push_error(c("a", "b")),
               "'msg' must be a single character string")
})

# ── push_warning / bioclim_warnings ──────────────────────────────────────────

test_that("push_warning stores a single warning message", {
  reset()
  xclim:::push_warning("minor issue")
  expect_true(has_warning())
  expect_equal(bioclim_warnings(), "minor issue")
})

test_that("push_warning accumulates multiple warnings", {
  reset()
  xclim:::push_warning("warn 1")
  xclim:::push_warning("warn 2")
  expect_equal(bioclim_warnings(), c("warn 1", "warn 2"))
})

test_that("push_warning rejects non-character input", {
  reset()
  expect_error(xclim:::push_warning(TRUE), "'msg' must be a character string")
})

# ── clear_messages ───────────────────────────────────────────────────────────

test_that("clear_messages resets both stores", {
  reset()
  xclim:::push_error("e")
  xclim:::push_warning("w")
  clear_messages()
  expect_false(has_error())
  expect_false(has_warning())
  expect_equal(bioclim_errors(),   character(0))
  expect_equal(bioclim_warnings(), character(0))
})

test_that("clear_messages returns invisible NULL", {
  reset()
  expect_invisible(clear_messages())
  expect_null(clear_messages())
})

# ── check_messages: error path ───────────────────────────────────────────────

test_that("check_messages throws when an error is stored", {
  reset()
  xclim:::push_error("a bad error")
  expect_error(xclim:::check_messages(), "a bad error")
})

test_that("check_messages clears the error store after throwing", {
  reset()
  xclim:::push_error("transient")
  tryCatch(xclim:::check_messages(), error = function(e) NULL)
  expect_false(has_error())
  expect_equal(bioclim_errors(), character(0))
})

test_that("check_messages concatenates multiple errors", {
  reset()
  xclim:::push_error("err A")
  xclim:::push_error("err B")
  err <- tryCatch(xclim:::check_messages(), error = function(e) e)
  expect_equal(conditionMessage(err), "err A\nerr B")
  # After throwing, store is clear
  expect_false(has_error())
})

# ── check_messages: warning path ─────────────────────────────────────────────

test_that("check_messages issues R warnings for stored warnings", {
  reset()
  xclim:::push_warning("heads up")
  expect_warning(xclim:::check_messages(), "heads up")
})

test_that("check_messages clears warning store after issuing", {
  reset()
  xclim:::push_warning("transient warn")
  suppressWarnings(xclim:::check_messages())
  expect_false(has_warning())
})

test_that("check_messages issues multiple R warnings", {
  reset()
  xclim:::push_warning("w1")
  xclim:::push_warning("w2")
  warns <- character(0)
  withCallingHandlers(
    xclim:::check_messages(),
    warning = function(w) {
      warns <<- c(warns, conditionMessage(w))
      invokeRestart("muffleWarning")
    }
  )
  expect_equal(warns, c("w1", "w2"))
  expect_false(has_warning())
})

# ── check_messages: no-op on empty store ────────────────────────────────────

test_that("check_messages is a no-op when store is empty", {
  reset()
  expect_silent(xclim:::check_messages())
  expect_invisible(xclim:::check_messages())
})

# ── error takes priority over warnings ──────────────────────────────────────

test_that("check_messages issues warnings before raising the error", {
  reset()
  xclim:::push_warning("pre-error warning")
  xclim:::push_error("fatal")
  warns <- character(0)
  tryCatch(
    withCallingHandlers(
      xclim:::check_messages(),
      warning = function(w) {
        warns <<- c(warns, conditionMessage(w))
        invokeRestart("muffleWarning")
      }
    ),
    error = function(e) NULL
  )
  expect_equal(warns, "pre-error warning")
  expect_false(has_warning())
  expect_false(has_error())
})

# ── independence of errors and warnings stores ───────────────────────────────

test_that("errors and warnings are stored independently", {
  reset()
  xclim:::push_error("only error")
  expect_false(has_warning())
  expect_equal(bioclim_warnings(), character(0))
  reset()
  xclim:::push_warning("only warning")
  expect_false(has_error())
  expect_equal(bioclim_errors(), character(0))
})
