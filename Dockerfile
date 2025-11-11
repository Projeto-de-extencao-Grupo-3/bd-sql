FROM mysql:8.0

COPY ./script-grotrack.sql /docker-entrypoint-initdb.d/

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=grotrack

EXPOSE 3306