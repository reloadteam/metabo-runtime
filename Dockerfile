FROM rstudio/plumber:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    libcairo2-dev \
    libnetcdf-dev \
    libxml2-dev \
    libxt-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libgit2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN R -q -e "options(repos = c(CRAN='https://cloud.r-project.org')); install.packages(c('BiocManager','devtools'), dependencies = TRUE)"

RUN R -q -e "pkgs <- c('impute','pcaMethods','globaltest','GlobalAncova','Rgraphviz','preprocessCore','genefilter','SSPA','sva','limma','KEGGgraph','siggenes','BiocParallel','MSnbase','multtest','RBGL','edgeR','fgsea','crmn'); BiocManager::install(pkgs, ask = FALSE, update = FALSE)"

RUN R -q -e "devtools::install_github('xia-lab/MetaboAnalystR', build = TRUE, build_vignettes = FALSE)"

WORKDIR /app

COPY plumber.R /app/plumber.R
COPY start.R /app/start.R

ENV PORT=8080
EXPOSE 8080

CMD ["Rscript", "/app/start.R"]
