FROM ktran9891/env_ulissi:latest
ARG USERNAME=ktran


# Expose the Jupyter port
EXPOSE 8888

# Change the entrypoint to start Jupyter instead
COPY start-notebook.sh /usr/local/bin/start-notebook.sh
ENTRYPOINT ["/bin/bash", "-c", "runuser -l ktran /usr/local/bin/start-notebook.sh"]
