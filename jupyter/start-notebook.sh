#!/bin/bash


# The mounting location (so we don't save to ephemeral container space)
cd /home/volume

# Load environment
source /home/ktran/miniconda3/bin/activate

########## Begin user-specific configurations ##########

# Configure environment
jt -t oceans16 -vim
jupyter nbextension enable vim_binding/vim_binding

########## End user-specific configurations ##########

# Launch Jupyter
jupyter notebook --no-browser --ip=0.0.0.0
