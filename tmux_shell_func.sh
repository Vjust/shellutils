# Purpose : A shell function to launch multiple tmux sessions
# Creates a new Tmux session for each of your projects/virtual environments
# It works in conjunction with the "tmux_startup.sh"
# Place this function in your ".bashrc" file or ".zshrc" (zshrc is assumed in the code).

function tlux()
{
    # usage : tlux proj1_dir proj1_dir/env
    # will create a session called proj1_dir, and execute the virtualenv
    #tmux list-session
    if [ $# = 0 ] ;
    then
	echo "usage tlux proj1_dir [env_dir] [tmux startup file]"
	return -1
    fi
    export homedir=$1
    export sessname=$(basename $homedir)
    if [ $# = 2 ] ; then
	export venv=$2
    else
	export venv=""
    fi
    export startup="~/.tmux.conf"
    if [ $# = 3 ]; then
	export startup=$3
    fi

    if ! tmux has-session -t $sessname 2>/dev/null; then
	echo "Creating new session home: ${homedir}, sess:${sessname}, venv:${venv}" 
	read
	tmux new-session -c $homedir -s $sessname -n aa -d  
	if [ $# = 3 ]; then
	   # startup is a file containing customized tmux session commands
	   # for each virtual env
	   zsh $startup
	fi
    else
	echo "attaching to an existing session $sessname"
	read
    fi	
    tmux attach -t $sessname
}
