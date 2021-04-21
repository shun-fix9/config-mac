#!/bin/zsh

PROPOSE_ORIGINAL_HELP=$PROPOSE_HELP
PROPOSE_HELP=${PROPOSE_ORIGINAL_HELP}$(cat <<"HELP_MESSAGE"


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
    propose_zle_clear
    git branch && git status && git stash list
}
propose_cmd_a(){
    propose_zle_clear
    git add -A .
}
propose_cmd_r(){
    propose_zle_clear
    git reset
}
propose_cmd_o(){
    propose_zle_clear
    git fetch --prune origin && git switch --detach origin/HEAD
}
propose_cmd_m(){
    propose_zle_clear
    git merge origin/$(git parent)
}
propose_cmd_up(){
    propose_zle_clear
    git parent-sync
}

propose_cmd_c(){
    BUFFER='git request-to-parent ""'
    CURSOR=23
}
propose_cmd_pub(){
    propose_zle_clear
    git pub
}
propose_cmd_post(){
    BUFFER='git post "" $(git parent)'
    CURSOR=10
}
propose_cmd_x(){
    propose_zle_clear
    git check-full-merged-into-parent-branch && git switch-parent-branch && git wipe-deleted-branch
}

propose_cmd_setup(){
    propose_zle_clear

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
