FROM jupyter/base-notebook

USER root

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get install gcc -y
RUN apt-get install libkrb5-dev -y
RUN apt-get install gettext -y

USER $NB_USER

RUN pip install sparkmagic --user
RUN pip install requests --upgrade --user

RUN jupyter nbextension enable --py widgetsnbextension

RUN jupyter-kernelspec install /home/$NB_USER/.local/lib/python3.6/site-packages/sparkmagic/kernels/sparkkernel --user
RUN jupyter-kernelspec install /home/$NB_USER/.local/lib/python3.6/site-packages/sparkmagic/kernels/pysparkkernel --user
RUN jupyter-kernelspec install /home/$NB_USER/.local/lib/python3.6/site-packages/sparkmagic/kernels/pyspark3kernel --user
RUN jupyter-kernelspec install /home/$NB_USER/.local/lib/python3.6/site-packages/sparkmagic/kernels/sparkrkernel --user

WORKDIR /home/$NB_USER

RUN mkdir .sparkmagic
RUN mkdir .config
ADD config.json.template .config/

EXPOSE 8888

ENV emr localhost

CMD ["/bin/bash", "-c", "envsubst < .config/config.json.template > .sparkmagic/config.json && start-notebook.sh"]

USER $NB_USER
