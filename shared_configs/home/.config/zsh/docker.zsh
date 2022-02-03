# list running container names
dockerps() { docker ps | awk 'NR>1 {print $NF}' }

# list all container names
dockerpsa() { docker ps -a | awk 'NR>1 {print $NF}' }

# list all container names catergorized
dps() {
    containers=$(dockerps; dockerpsa)
    running=$(echo "$containers" | sort | uniq -d)
    stopped=$(echo "$containers" | sort | uniq -u)
    [ "$running" ] && printf "----------\n RUNNING:\n----------\n%s\n" "$running"
    [ "$stopped" ] && printf "----------\n STOPPED:\n----------\n%s\n" "$stopped"
}

# remove running containers
drm() { docker rm -vf $(dockerps | tr "\n" " ") }

# remove all containers
drma() { docker rm -vf $(dockerpsa | tr "\n" " ") }
