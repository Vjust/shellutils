# add this snippet to your bashrc file
# and source it.
# usage "gclone userid github-repo-name
function gclone() {
	user=$1
	project=$2.git
	git clone git@github.com:${user}/${project}
}
