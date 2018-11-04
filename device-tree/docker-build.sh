IMAGE_TAR=device-tree.tar
docker build . --tag bclouser/device-tree:latest && docker save -o ${IMAGE_TAR} bclouser/device-tree:latest

if [ ! -z $1 ]; then
	scp ${IMAGE_TAR} $1 
fi
