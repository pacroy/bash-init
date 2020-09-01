# Azure CLI
alias azset='az account set -s'
alias azls='az account list -o table'
azaks() { 
    az aks get-credentials --resource-group $1 --name $2
}

# Kubernetes CLI
alias kc='kubectl'
alias kcls='kc config get-contexts'
alias kcuse='kc config use-context'
kcsetns() { 
    kc config set-context $(kc config current-context) --namespace $1
}
kcstatus() { 
    kc rollout status deploy $1
}

# Terraform
alias tf='terraform'

# Git
gitscan() {
    for d in */
    do
        echo -e "[$d]"
        cd $d
        git status
        cd ..
        echo ""
    done
}
alias gitl='git log --oneline --decorate --all'
alias gitt='git tag -n1'
alias gits='git status --ignored'
alias gitb='git branch -vv'
alias gitp='git push && git push --tags'
alias gitd='git diff'
alias gitu='git pull'
gita() {
    git add "$@"
}
gitc() { 
    git commit -m "$1" 
}
gitz() { 
    gita .
    gitc "$1"
    gitp 
}

# Alias
alias update-alias='curl -sSL http://par.sh/alias -o ~/alias.sh && source ~/alias.sh'