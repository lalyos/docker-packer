
Docker file to build [packer](http://packer.io) binaries.
This image build on top of the official golang image,
and follows the steps described in the 
packer [docs](https://github.com/mitchellh/packer#developing-packer)

## Build the images

The usual steps:

```
git clone https://github.com/lalyos/docker-packer.git
cd docker-packer
docker build -t packer .
```

## Usage

The image uses:
 * `/data` volume as working dir
 * `/go/bin/packer` as entrypoint
 * environment variables for authentication

So if you want to validate a packer.json file in the current dir,
which uses amazon-ebs builder:

```
docker run -it \
  -v $(pwd):/data \
  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  packer validate /data/packer.json
```

If you use for example the atlas postprocessor, add a new environment valirable:

```
-e ATLAS_TOKEN=$ATLAS_TOKEN
```

