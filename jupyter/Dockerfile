FROM ktran9891/env_ulissi:latest


# Install Jupyter
RUN conda install jupyter

########## Begin user-specific configurations ##########

# Switch to user so home directories etc. behave as we expect
USER $USERNAME

# Jupyter extension manager
RUN conda install jupyter_nbextensions_configurator

# Vim bindings for Jupyter
RUN mkdir -p $(jupyter --data-dir)/nbextensions
RUN git clone https://github.com/lambdalisue/jupyter-vim-binding $(jupyter --data-dir)/nbextensions/vim_binding
RUN jupyter nbextension enable vim_binding/vim_binding

# Jupyter theme
RUN pip install jupyterthemes
RUN jt -t oceans16

# Switch back to root for proper control
USER root

########## End user-specific configurations ##########

# Expose the Jupyter port
EXPOSE 8888

# Change the entrypoint to start Jupyter instead
COPY start-notebook.sh /usr/local/bin/start-notebook.sh
ENTRYPOINT ["/bin/bash", "-c", "runuser -l ktran /usr/local/bin/start-notebook.sh"]
