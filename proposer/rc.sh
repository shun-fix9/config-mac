#!/bin/sh

PROPOSE_HELP=$(cat <<HELP_MESSAGE
${PROPOSE_HELP}

s  -> git branch && git status && git stash list
a  -> git add -A .
r  -> git reset
o  -> git fetch origin && git switch detached-origin/HEAD
m  -> git merge origin/$(git parent)
up -> git parent-sync

c    -> git request-to-parent <message>
pub  -> git pub
post -> git post <message> $(git parent)
x    -> git check-full-merged && git switch-parent && git wipe-deleted

setup -> git config --local user.[name | email] && git reg-pub
HELP_MESSAGE
)

propose_cmd_s(){
    git branch && git status && git stash list
}
propose_cmd_a(){
    git add -A .
}
propose_cmd_r(){
    git reset
}
propose_cmd_o(){
    git fetch --prune origin && git switch --detach origin/HEAD
}
propose_cmd_m(){
    git merge origin/$(git parent)
}
propose_cmd_up(){
    git parent-sync
}

propose_cmd_c(){
    propose_read_and_run 'git request-to-parent "$1"'
}
propose_cmd_pub(){
    git pub
}
propose_cmd_post(){
    propose_read_and_run 'git post "$1" $(git parent)'
}
propose_cmd_x(){
    git check-full-merged-into-parent-branch && git switch-parent-branch && git wipe-deleted-branch
}

propose_cmd_setup(){
    # setup name/email
    local name
    local email

    name=shun
    email=shun.fix9@gmail.com

    git config --local user.name $name
    git config --local user.email $email
    echo "$name : $email"

    # reg-pub
    local github
    local gitlab

    github=shun-fix9
    gitlab=shun-fix9-forks

    git reg-pub github:$github gitlab:$gitlab
    echo "github:$github / gitlab:$gitlab"
}
