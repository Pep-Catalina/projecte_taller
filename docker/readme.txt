docker image build -t nginx-digitalitzacio docker/nginx/.
docker image build -t api-digitalitzacio docker/api/.
docker image build -t mariadb-digitalitzacio docker/mysql/.

docker network create --driver bridge --gateway 192.168.1.254 --subnet 192.168.1.0/24 --attachable digi-network

docker container run -d --name nginx-digitalitzacio --dns 192.168.1.1 --network digi-network --ip 192.168.1.1 -p 8080:80 -p 4433:443 --hostname srv-web nginx-digitalitzacio
docker container run -d --name api-digitalitzacio --dns 192.168.1.1 --network digi-network --ip 192.168.1.2 -p 5000:5000 --hostname srv-api api-digitalitzacio
docker container run -d --name mariadb-digitalitzacio -e MYSQL_ROOT_PASSWORD=Educem00 --dns 192.168.1.1 --dns-search centremedic.cat --network digi-network --ip 192.168.1.3 -p 3366:3306 --hostname srv-db mariadb-digitalitzacio

docker-compose up -d --build