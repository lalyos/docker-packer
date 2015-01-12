
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

## tl;dr

Packer has some [issues](https://github.com/mitchellh/goamz/issues/120), 
when using the **amazon-ebs** builder against:

 * eu-central-1
 * cn-north-1

The 2 new region uses the latest v4 signature algorithm for ec2. Packer uses
the [goamz](https://github.com/mitchellh/goamz) library which doesn't yet switched
for the latest sign algorythm.

There is an open [pull request](https://github.com/mitchellh/goamz/pull/154) which
is used to fix packer.




