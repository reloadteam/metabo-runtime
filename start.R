port <- as.integer(Sys.getenv("PORT", "8080"))
pr <- plumber::plumb("/app/plumber.R")
pr$run(host = "0.0.0.0", port = port)
