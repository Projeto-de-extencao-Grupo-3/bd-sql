## Docker

## Criando imagem do banco de dados
``` bash 
docker build -t bd-grotrack 
```

## Adicionando tag para a imagem
``` bash 
docker tag bd-grotrack:latest erickym/bd-grotrack:latest 
```

## Subindo a imagem no docker hub
``` bash 
docker push erickym/bd-grotrack:latest 
```

## Pegar a imagem no docker hub
``` bash 
docker pull erickym/bd-grotrack:latest
```
