FROM rstudio/plumber:latest

WORKDIR /app

COPY plumber.R /app/plumber.R
COPY start.R /app/start.R

ENV PORT=8000
EXPOSE 8000

CMD ["Rscript", "/app/start.R"]
