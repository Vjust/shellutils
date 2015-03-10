# Purpose : this file is executed one time, *after* a new tmux session is created.
#           It bootstraps your development/shell session by doing mechanical tasks
#           such as firing up ipython, doing a git status, running servers etc
#           
#           This file is invoked from the tlux shell function .

# Notes 
#            ffenv is a wrapper that activates a virtualenv
#            solr and celery are used here as examples
#            of servers that are startedup 

win=1
tmux send-keys -t $sessname 'solex' C-m
tmux split-window -v -t $sessname:$win
tmux rename -t $sessname:$win solr-celery
tmux send-keys -t $sessname:$win.2 '~coo; ffenv; mm celeryd' C-m

#run the dev django wsgi server
win=2
tmux new-window -n app -t $sessname
tmux send-keys -t $sessname:$win '~coo;ffenv;ll' C-m
tmux send-keys -t $sessname:$win 'gunicorn --workers=1 -t 3600 my_django_proj.wsgi:application' C-m

# run ipython
win=3
tmux new-window -n ipython -t $sessname
tmux send-keys -t $sessname:$win '~coo;ffenv' C-m
tmux send-keys -t $sessname:$win 'export DJANGO_SETTINGS_MODULE=my_django_proj.settings' C-m
tmux send-keys -t $sessname:$win 'export EDITOR=emacsclient' C-m
tmux send-keys -t $sessname:$win 'ipython' C-m
# optional:do common imports
#tmux send-keys -t $sessname:$win 'import re, os, system, urllib2, urlparse' C-m
#tmux send-keys -t $sessname:$win 'from my_django_app.models import *' C-m
# optional:if using ipython notebook..
##send-keys -t $sessname:3 'ipython notebook --no-browser --port=8888' C-m


#git start
win=4
tmux new-window -n git -t $sessname
tmux send-keys -t $sessname:$win '~coo;ffenv' C-m
tmux send-keys -t $sessname:$win 'git remote update' C-m
tmux send-keys -t $sessname:$win 'git status' C-m


#mysql window
#new-window -n mysql -t $sessname
#send-keys -t $sessname:5 '~coo;venv' C-m
#send-keys -t $sessname:5 'mysql -D corroborator -u vjust -p' C-m
