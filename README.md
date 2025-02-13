[![Docker Repository on Quay](https://quay.io/repository/bgruening/cellxgene-vip/status "Docker Repository on Quay")](https://quay.io/repository/bgruening/cellxgene-vip)

# docker-cellxgene-vip

Docker image with cellxgene and the VIP plugins.

To build this container you can use the following command:

```bash
docker build -t CONTAINER_NAME .
docker run --rm -it -p 5005:5005 -v PATH/TO/DATA/CONTAINING/DIRECTORY:/data CONTAINER_NAME launch /data/FILE.h5ad --host 0.0.0.0 --port 5005
```

The original Dockerfile is from [Benedikt Obermayer (bobermayer)](https://github.com/bobermayer/cellxgene_vip/blob/master/docker/Dockerfile).
