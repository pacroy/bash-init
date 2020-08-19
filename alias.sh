# Azure CLI
alias azset='az account set -s'
alias azlist='az account list -o table'
azaks() { az aks get-credentials --resource-group $1 --name $2; }

# Kubernetes CLI
alias kc='kubectl'
alias kclist='kc config get-contexts'
alias kcuse='kc config use-context'
kcsetns() { context=$(kc config current-context); kc config set-context $context --namespace $1; }
kcstatus() { kc rollout status deploy $1; }

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
alias gitlog='git log --oneline --decorate --all'
alias gittag='git tag -n1'
alias gitst='git status --ignored'
alias gitbr='git branch -vv'
alias gitc="git commit -am $1"
alias gitp="git push && git push --tags"
alias gitd="git diff"

# Alias
alias update-alias='curl -sS https://raw.githubusercontent.com/pacroy/bash-init/master/init.sh | bash - && source ~/alias.sh'