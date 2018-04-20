# docker-jupyter-emr

This Dockerfile builds an image that can specify an EMR host using the emr environment variable. This requires Livy support in EMR 5.9.0+.

```
docker build -t jupyter-emr .
docker run -p 8888:8888 -it -e emr=<emr_master_hostname> jupyter-emr
```
