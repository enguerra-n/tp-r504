docker network create -d bridge net-tp4

echo "le network suivant vient d'être créé : "

docker network ls | grep net