## Docker

## Pegar a imagem no docker hub
``` bash 
docker pull gabrielpacificooo/grotrack:database
```

## Comando para rodar o container
``` bash 
docker run -d   --name database-grotrack   -e MYSQL_ROOT_PASSWORD=123456   -e MYSQL_DATABASE=grotrack   -p 3306:3306   -v mysql-data:/var/lib/mysql   gabrielpacificooo/grotrack:database
```
