

# Lumen-docker-kubernetes

From here you will be able to know that how you will run your  Laravel project using Docker and how you will deploy using Kubernetes(minikube) 

### Run the project using docker

``` 
Clone the project
 
 ```
 
 Now run the following command from your terminal one by one. Running the commands be sure that you have installed docker.You will get install instructions from this
 [link](https://docs.docker.com/)

in development mode using docker compose
```
sudo docker-compose build && sudo docker-compose up -d
```
in production mode using docker build 
```sh
sudo docker build -t [image name]:[image version] .

```
for image default is using port 80 

```sh
sudo docker create --name [container name] -p 8080:80 [image name]:[image version]

```

Now browse project 

 ```
 http://[ip host/localhost]:8080/

```
### Important
First you need to run command composer install to install vendor and make sure in your computer installed composer
```
composer install 
```
 

