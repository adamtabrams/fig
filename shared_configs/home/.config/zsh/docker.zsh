# list running container names
dps() { docker ps | awk 'NR>1 {print $NF}' }

# list all container names
dpsa() { docker ps -a | awk 'NR>1 {print $NF}' }

# remove running containers
drm() { docker rm -vf $(dps | tr "\n" " ") }

# remove all containers
drma() { docker rm -vf $(dpsa | tr "\n" " ") }
