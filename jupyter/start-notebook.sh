#!/bin/bash


# Go to the correct folder
cd /home/volume

# Start up Jupyter
source /home/ktran/miniconda3/bin/activate
jupyter notebook --no-browser --ip=0.0.0.0
