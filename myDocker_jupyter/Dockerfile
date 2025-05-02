FROM continuumio/miniconda3
RUN conda config --set ssl_verify false \
    && conda install \
    xarray \ 
    netCDF4 \ 
    bottleneck \
    numpy \
    pandas \
    matplotlib \
    jupyterlab \
    nodejs
CMD ["jupyter-lab","--ip=0.0.0.0","--no-browser","--allow-root"]
