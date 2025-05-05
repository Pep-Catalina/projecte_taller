docker image build -t nginx-digitalitzacio docker/nginx/.

docker image build -t mariadb-digitalitzacio docker/mysql/.

docker network create --driver bridge --gateway 192.168.1.254 --subnet 192.168.1.0/24 --attachable digi-network

docker container run -d nginx-digitalitzacio --dns 192.168.1.1 --dns-search centremedic.cat --network digi-network --ip 192.168.1.1 -p 8080:80 -p 4433:443 --hostname srv-centremedic nginx-digitalitzacio

docker container run -d mariadb-digitalitzacio -e MYSQL_ROOT_PASSWORD=Educem00. --dns 192.168.1.1 --dns-search centremedic.cat --network digi-network --ip 192.168.1.2 -p 3366:3306 --hostname srv-centremedic mariadb-digitalitzacio