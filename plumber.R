# plumber.R
library(plumber)
library(jsonlite)

metabo_loaded <- requireNamespace("MetaboAnalystR", quietly = TRUE)

#* Health check
#* @get /health
function() {
  list(
    status = "ok",
    service = "metaboanalyst-r-runtime",
    metaboanalyst_loaded = metabo_loaded,
    time_utc = format(Sys.time(), tz = "UTC", usetz = TRUE)
  )
}

#* Version info
#* @get /version
function() {
  list(
    service = "metaboanalyst-r-runtime",
    r_version = as.character(getRversion()),
    plumber_version = as.character(utils::packageVersion("plumber")),
    metaboanalyst_version = if (metabo_loaded) as.character(utils::packageVersion("MetaboAnalystR")) else NA_character_
  )
}

#* Normalize compounds placeholder
#* @post /normalize-compounds
#* @serializer json list(na = "string")
function(req, res) {
  body <- jsonlite::fromJSON(req$postBody, simplifyVector = FALSE)
  metabolites <- body$metabolites %||% list()
  mapped <- lapply(metabolites, function(x) {
    list(
      input = x,
      status = "not_implemented_yet",
      note = "This endpoint is a placeholder. Use Base44 + mapcompounds first, or implement local mapping later."
    )
  })
  list(ok = TRUE, mapped = mapped)
}

`%||%` <- function(a, b) if (!is.null(a)) a else b

#* Run analysis placeholder
#* @post /run
#* @serializer json list(na = "string")
function(req, res) {
  body <- jsonlite::fromJSON(req$postBody, simplifyVector = FALSE)
  list(
    accepted = TRUE,
    status = "stub",
    message = "R runtime is working. Actual MetaboAnalystR workflows still need to be implemented.",
    received_workflow = body$workflow_code %||% NA_character_,
    metaboanalyst_loaded = metabo_loaded
  )
}
