function docker-clean --description "Docker - Clean All"
  # Stop and Remove All Containers
  docker stop $(docker ps -a -q)
  docker rm -f $(docker ps -a -q)

  # Remove All Images
  docker rmi -f $(docker images -a -q)

  # Remove All Volumes
  docker volume rm -f $(docker volume ls -q)
end
