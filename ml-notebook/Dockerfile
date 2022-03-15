FROM jupyter/all-spark-notebook:2021-11-10

MAINTAINER xiaomao23zhi <https://github.com/xiaomao23zhi/>

USER root

# Install packages
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    graphviz \
    julia \
    language-pack-zh-hans && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
 
# Fix font
COPY --chown=${NB_UID}:${NB_GID} ./simhei.ttf /opt/conda/lib/python3.9/site-packages/matplotlib/mpl-data/fonts/ttf/simhei.ttf

# Before notebook script for sparkmagic
COPY ./sparkmagic.sh /usr/local/bin/before-notebook.d/sparkmagic.sh
RUN chmod +x /usr/local/bin/before-notebook.d/sparkmagic.sh

USER ${NB_USER}

# Add user-settings
COPY --chown=${NB_UID}:${NB_GID} user-settings/ /home/jovyan/.jupyter/lab/user-settings/

# Python packages
RUN pip install --no-cache-dir \
    scikit-learn \
    category-encoders \
    kmodes \
    jupyter-resource-usage \
    jupyterlab_execute_time \
    jupyterlab-system-monitor \
    jupyterlab-lsp \
    python-lsp-server[all] \
    papermill \
    xgboost && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# R packages
RUN R -e "install.packages(c('igraph','languageserver'), dependencies=TRUE, repos='http://cran.rstudio.com/')"

# iJulia packages
RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'import Pkg; Pkg.add("HDF5")' && \
    julia -e 'using Pkg; Pkg.add.(["IJulia", "LanguageServer"]); pkg"precompile"' && \
    # move kernelspec out of home \
    mv "${HOME}/.local/share/jupyter/kernels/julia"* "${CONDA_DIR}/share/jupyter/kernels/" && \
    chmod -R go+rx "${CONDA_DIR}/share/jupyter" && \
    rm -rf "${HOME}/.local" && \
    fix-permissions "${CONDA_DIR}/share/jupyter"

# Install sparkmagic
RUN pip install --no-cache-dir sparkmagic && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" && \
    jupyter-kernelspec install --user $(pip show sparkmagic | grep Location | cut -d" " -f2)/sparkmagic/kernels/sparkkernel && \
    jupyter-kernelspec install --user $(pip show sparkmagic | grep Location | cut -d" " -f2)/sparkmagic/kernels/pysparkkernel && \
    jupyter serverextension enable --py sparkmagic && \
    jupyter labextension disable ipyparallel-labextension
RUN mkdir /home/$NB_USER/.sparkmagic

COPY ./config.json.template /home/$NB_USER/.sparkmagic/config.json.template
COPY ./logo/spark-logo-64x64.png /home/jovyan/.local/share/jupyter/kernels/sparkkernel/logo-64x64.png

# Install Dask
RUN conda create --name dask && \
    source activate dask
RUN pip install --no-cache-dir \
    dask-gateway \
    dask-ml \
    dask-labextension \
    && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" && \
    python -m ipykernel install --user --name dask --display-name "Dask"
COPY ./logo/dask-logo-64x64.png /home/jovyan/.local/share/jupyter/kernels/dask/logo-64x64.png

# Install sparkmonitor
RUN pip install --no-cache-dir \
    sparkmonitor \
    && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
RUN jupyter nbextension install sparkmonitor --py --user && \
    jupyter nbextension enable  sparkmonitor --py && \
    jupyter lab build && \
    ipython profile create && \
    echo "c.InteractiveShellApp.extensions.append('sparkmonitor.kernelextension')" >>  /home/${NB_USER}/.ipython/profile_default/ipython_kernel_config.py

# Install Tensorflow
RUN conda create --name tensorflow && \
    source activate tensorflow
RUN pip install --no-cache-dir \
    tensorflow \
    tensorboard \
    Keras \
    && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" && \
    python -m ipykernel install --user --name tensorflow --display-name "Tensorflow"
COPY ./logo/tensorflow-logo-64x64.png /home/jovyan/.local/share/jupyter/kernels/tensorflow/logo-64x64.png

# Install tensorboard
RUN pip install --no-cache-dir git+https://github.com/cliffwoolley/jupyter_tensorboard.git && \
    pip install --no-cache-dir git+https://github.com/chaoleili/jupyterlab_tensorboard.git

# clean up
RUN rm -rf ~/.cache/pip ~/.cache/yarn

# Dask Scheduler & Bokeh ports
EXPOSE 8787
EXPOSE 8786

WORKDIR "${HOME}"

USER $NB_UID
