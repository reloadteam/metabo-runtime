FROM rocker/r-ver:4.3.3

RUN apt-get update && apt-get install -y --no-install-recommends \
    r-cran-plumber \
    r-cran-jsonlite \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY plumber.R /app/plumber.R
COPY start.R /app/start.R

ENV PORT=8000
EXPOSE 8000

CMD ["Rscript", "/app/start.R"]
