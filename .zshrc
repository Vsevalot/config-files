export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/Users/vsevalot/Applications/bin:$PATH"

# EXPECTED TOOLS
# - fzf: https://github.com/junegunn/fzf
# - fd (better find): https://github.com/sharkdp/fd
# - bat (better cat): https://github.com/sharkdp/bat
# - eza (better ls): https://github.com/eza-community/eza
# - zoxide (better cd): https://github.com/ajeetdsouza/zoxide

ZSH_THEME="avit"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

alias v="nvim"

# ---- FZF -----
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_T_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

_fzf_compgen_path() {
  fd --hidden --exclude .git "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ---- BAT ----
BAT_THEME="Catppuccin Mocha"

# ---- EZA ----
alias ls="eza --icons=always --long --no-filesize --no-time --no-user --no-permissions"

# ---- zoxide ----
eval "$(zoxide init zsh)"
alias cd="z"


alias k=kubectl
alias kd="kubectl describe"
alias kget="kubectl config get-contexts"
alias kuse="kubectl config use-context"
alias aws-pierce-shell="k exec -it -c app deploy/pierce -- /vault/vault-env bash -c 'python src/manage.py shell -w'"
alias aws-pierce-bash="k exec -it -c app deploy/pierce -- /vault/vault-env bash"
alias cg="kubectl get pods -l managed_by=containerhub -o jsonpath='{range .items[*]}
{\"id:      \"}{.metadata.name}
{\"user:    \"}{.metadata.labels.user_id}
{\"name:    \"}{.metadata.labels.container_name}
{\"img:     \"}{.spec.containers[0].image}
{\"cearted: \"}{.metadata.labels.created_at}
{\"updated: \"}{.metadata.labels.updated_at}
{\"---------------------------------\"}{end}'"

source <(kubectl completion zsh)
