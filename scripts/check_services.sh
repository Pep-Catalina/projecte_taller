
#!/bin/bash
curl -s http://localhost:5000/vehicles && echo "API OK" || echo "API KO"
docker exec db mysqladmin ping -uroot -pexample && echo "DB OK" || echo "DB KO"
