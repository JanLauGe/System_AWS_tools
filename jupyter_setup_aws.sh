# Create a jupyter notebook server on AWS EC2 instance

# Download and install anaconda for linux installer (Python 2.7)
wget https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh
bash Anaconda2-4.2.0-Linux-x86_64.sh

#===============================================================================
### Confirm license agreement and installation path...
#===============================================================================

export PATH=/home/ubuntu/anaconda2/bin:$PATH
source .bashrc
which python 
#should be /home/ubuntu/anaconda2/bin/python

# Configure jupyter notebook
jupyter notebook --generate-config

mkdir certs
cd certs
sudo openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out mycert.pem
# Then fill in required information

# Change jupyter configuration
cd ~/.jupyter/
vim jupyter_notebook_config.py
#==============================================================================
### insert this at the top:
c = get_config()

# Notebook config this is where you saved your pem cert
c.NotebookApp.certfile = u'/home/ubuntu/certs/mycert.pem' 
# Run on all IP addresses of your instance
c.NotebookApp.ip = '*'
# Don't open browser by default
c.NotebookApp.open_browser = False  
# Fix port to 8888
c.NotebookApp.port = 8888
#==============================================================================

# Start notebook server
jupyter notebook

### Connect via https://ec2-xx-xx-xxx-xxx.us-west-2.compute.amazonaws.com:8888

