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

RUN R -q -e "options(repos = c(CRAN='https://cloud.r-project.org')); install.packages(c('plumber','jsonlite'), dependencies = TRUE); stopifnot(requireNamespace('plumber', quietly = TRUE)); stopifnot(requireNamespace('jsonlite', quietly = TRUE))"

WORKDIR /app

COPY plumber.R /app/plumber.R
COPY start.R /app/start.R

ENV PORT=8000
EXPOSE 8000

CMD ["Rscript", "/app/start.R"]
