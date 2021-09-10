MONGO_CONNECTION_STRING=mongodb://localhost:27017
MONGO_CONTAINER_NAME=mongo
MONGO_DATABASE=rainback
MONGO_BACKUP_PATH=db.dump

run:
	sudo docker run --name mongo -it -p 127.0.0.1:27017:27017 -v /media/mongo:/data/db --rm mongo

mongosh shell sh:
	sudo docker exec -it $(MONGO_CONTAINER_NAME) mongosh

backup:
	sudo docker exec mongo sh -c "exec mongodump -d $(MONGO_DATABASE) --archive" >$(MONGO_BACKUP_PATH)-`date -Is`

restore:
	sudo docker exec mongo sh -c "mongorestore --drop --archive=/db.bson $(MONGO_CONNECTION_STRING)"
