#!/bin/bash
INSTALLPATH=/docker/pathfinder-dockerized

case $1 in
	"rebuildpf")
	docker-compose stop pathfinder
	docker-compose rm pathfinder
	docker rmi pathfinderdockerized_pathfinder
	docker-compose up -d --no-deps --build pathfinder
	;;

	"build")
	docker-compose up -d
	;;

	"backup")
	if [ "$2" == "" ]; then
		echo "Error: Missing Argument"
		echo "Usage: $0 $1 DBPassWord"
		exit 1
	fi
	docker run --rm -ti --network pathfinderdockerized_default --link mysql -v $INSTALLPATH/backup:/backup -v $INSTALLPATH/scripts:/scripts pathfinderdockerized_pathfinder /scripts/dbdump.sh $2
	;;

	"restore")
	if [ "$2" == "" ] || [ "$3" == "" ]; then
		echo "Error: Missing Argument"
		echo "Usage: $0 $1 DBPassWord"
		exit 1
	fi
	docker run --rm -ti --network pathfinderdockerized_default --link mysql -v $INSTALLPATH/backup:/backup -v $INSTALLPATH/scripts:/scripts pathfinderdockerized_pathfinder /bin/bash /scripts/dbimport.sh $2 $3
	;;

	"stop")
	docker-compose stop
	;;

	"start")
	docker-compose start
	;;

	"clean")
	docker-compose down
	;;

	"logs")
	docker-compose logs -f 
	;;

	"status")
	docker-compose ps
	;;

	*)
	echo "$0 [status|build|start|stop|clean]"
esac

