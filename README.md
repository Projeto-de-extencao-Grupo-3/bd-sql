## Docker

## Criando imagem do banco de dados
``` bash 
docker build -t bd-grotrack 
```

## Adicionando tag para a imagem
``` bash 
docker tag bd-grotrack:latest nome-usuario/bd-grotrack:latest 
```

## Subindo a imagem no docker hub
``` bash 
docker push nome-usuario/bd-grotrack:latest 
```
