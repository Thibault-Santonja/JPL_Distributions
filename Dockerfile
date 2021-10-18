FROM python:3.9-alpine


# Upgrade apk & install bash and git
# libc-dev & alpine-sdk install the C build tools required for some Python libs like Numpy
# ffmpeg for matplotlib anim & dvipng+cm-super for latex labels
# libffi-dev for Jupyter
WORKDIR /opt
RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash \
                       git \
                       ffmpeg \
                       libc-dev \
                       alpine-sdk \
                       libffi-dev && \
    pip3 install notebook  \
                 jupyter \
                 ipywidgets && \
    jupyter nbextension enable --py widgetsnbextension && \
    pip3 install jupyterlab && \
    jupyter serverextension enable --py jupyterlab
    # && pip3 install numpy pandas matplotlib seaborn scikit-learn scipy


# Add user & change to it
ENV JPL_USER=colere
ENV USER_HOME=/home/$JPL_USER
ENV PATH=$PATH:$USER_HOME
RUN adduser -D -u 1042 $JPL_USER && \
    chmod g+w /etc/passwd


# Expose Jupyter port & cmd
USER $JPL_USER
WORKDIR $USER_HOME
RUN mkdir -p $USER_HOME/.jupyterlab/user-settings/@jupyterlab/apputils-extension/ && \
    echo '{ "theme":"JupyterLab Dark" }' > $USER_HOME/.jupyterlab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings
EXPOSE 8888
CMD ["jupyter-lab", "--ip=*", "--port=8888", "--no-browser"]