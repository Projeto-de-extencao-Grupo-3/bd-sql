FROM mysql:8.0

COPY ./script-grotrack.sql /docker-entrypoint-initdb.d/
EXPOSE 3306