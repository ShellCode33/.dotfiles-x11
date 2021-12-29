# Load command completion plugin
autoload -Uz compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Process hidden files as well

# Load colors names for a more readable PROMPT variable
autoload -U colors && colors

# VCS plugin that enables branch name extracting from git repositories
autoload -Uz vcs_info

# History plugin that sets the cursor to the end of the command when navigating
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# ZSH history settings
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=5000

# Environment variables
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin"
export EDITOR='nvim'
export MANPAGER='nvim +Man!'
export PAGER='most'
export WORDCHARS='-_'
export LANG='en_GB.UTF-8'
eval "$(command dircolors)" # sets LS_COLORS environment variable

# Share history between sessions
setopt inc_append_history

# Autotab complete configuration
zstyle ':completion:*' menu select

# Group completions by type (files, builtins, commands, etc.)
zstyle ':completion:*' group-name ''

# Sort files completion entries by last modified
zstyle ':completion:*' file-sort modification

# Case insensitive path completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# Default completion colors uses ls ones
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

# General purpose completion colors
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}# %d%f'
zstyle ':completion:*:parameters' list-colors '=*=32'
zstyle ':completion:*:options' list-colors '=^(-- *)=32'

# Kill completion
zstyle ':completion:*:*:kill:*' list-colors '=(#b) #([0-9]#)*( *[a-z])*=34=31=33'

# Man completion
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# Custom vcs_info formatting (branch name only)
zstyle ':vcs_info:git:*' formats " %{[33m%}[%b]%{[0m%}"

# Checking requirements to make sure this zshrc is usable
requirements=(nvim fzf lf)

for requirement in "${requirements[@]}"
do
    if ! loc="$(type -p "$requirement")" || [[ -z "$loc" ]]
    then
        echo "You must install '$requirement' for this .zshrc to work properly !"
    fi
done

# Function that runs before each command
precmd() {
    local max_path_entries
    vcs_info

    # If we're in a git repository, we shorten the path
    if [[ -n ${vcs_info_msg_0_} ]]; then
        max_path_entries=3
    fi

    PROMPT="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%${max_path_entries}~%{$fg[red]%}]%b${vcs_info_msg_0_} $ "
}

# Function that wraps the git command in order to use nvim when possible
git() {
    if [[ "$1" = "show" ]] || [[ "$1" = "log" ]]
    then
        if command git "$@" > /tmp/git.$$
        then
            nvim /tmp/git.$$
        fi

        rm /tmp/git.$$
    else
        command git "$@"
    fi
}

# Function that run lf and cd into the last visited directory
lfcd() {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# Vim key bindings in ZSH
ZVM_INIT_MODE=sourcing
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# ZSH syntax highlighting
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Key bindings (man terminfo)
bindkey "${terminfo[kdch1]}" delete-char
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}"  end-of-line
bindkey "${terminfo[kcuu1]}" history-beginning-search-backward-end
bindkey "${terminfo[kcud1]}" history-beginning-search-forward-end
bindkey "^[[1;5D"            backward-word
bindkey "^[[1;5C"            forward-word

# Key bindings (tab completion)
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Key bindings (external tools)
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
bindkey -s '^o' 'lfcd\n' # see lfcd function declaration above

# Aliases
alias cp="cp -i"
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l'
alias l='ls -lA'
alias ipa='ip -c -br a'
alias vim='nvim'
alias gs='git status'
alias gd='git difftool -x "nvim -d"'
alias xo='xdg-open'

# Clean temp variables
unset requirements
unset requirement
unset loc
