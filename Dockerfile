FROM rocker/r-ver:4.3.3

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    make \
    curl \
    ca-certificates \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libicu-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN R -q -e "options(repos = c(CRAN='https://cloud.r-project.org')); install.packages(c('plumber','jsonlite'), dependencies = TRUE); stopifnot(requireNamespace('plumber', quietly = TRUE)); stopifnot(requireNamespace('jsonlite', quietly = TRUE)); cat('plumber installed successfully\\n')"

WORKDIR /app
COPY plumber.R /app/plumber.R

ENV PORT=8000
EXPOSE 8000

CMD ["R", "-q", "-e", "pr <- plumber::plumb('/app/plumber.R'); pr$run(host='0.0.0.0', port=as.integer(Sys.getenv('PORT', '8000')))"]
