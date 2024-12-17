docker run \
    -p 5000:5000 \
    --network net-tp4 \
    --mount type=bind,src=$(pwd),target=/srv \
    im-tp4