function docker-rebuild --description "Docker - Rebuild Project"
  # Restart Docker Compose
  docker-compose down --volumes
  docker-compose up --build
end
