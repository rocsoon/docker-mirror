#!/bin/sh
echo "todo..."

echo "docker login..."
docker login -u $DOCKER_REGISTRY_USERNAME -p $DOCKER_REGISTRY_PASSWORD $DOCKER_REGISTRY_URL

filename="images.txt"
echo "reading images..."

while read -r line
do
    image="$line"

    echo "pull image - $image"
    docker pull $image

    tag_image=${image//\//-}

    echo "tag image - $tag_image"
    docker tag $image $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_NAMESPACE/$tag_image

    echo "push image - $tag_image"
    docker push $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_NAMESPACE/$tag_image

done < "$filename"

echo "done!"
