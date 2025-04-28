
#!/bin/bash
docker exec db sh -c 'exec mysqldump --all-databases -uroot -pexample' > backup.sql
