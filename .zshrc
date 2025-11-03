# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# if [[ -n "$ZSH_DEBUGRC" ]]; then
#         zmodload zsh/zprof
# fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$PATH:$HOME/.cargo/bin/"

export EDITOR=nvim

export ZSH="$HOME/.oh-my-zsh"

LLS_Addons=$HOME/.config/nvim/LLS-Addons/

export FZF_DEFAULT_OPTS='
--color=fg:#6c7086,fg+:,bg:,bg+:#0e0e16
--color=hl:#cdd6f4,hl+:#F38BA8,info:#f9e2af,marker:#F38BA8
--color=prompt:#f9e2af,spinner:#f9e2af,pointer:#af5fff,header:#ababab
--color=gutter:#0e0e16,border:#0e0e16,label:#cdd6f4,query:#cdd6f4
--border="none" --border-label-pos="0" --preview-window="border-bold"
--padding="1" --margin="0" --prompt="> " --marker="󰨓 "
--pointer="" --separator="" --scrollbar="" --layout="reverse" --preview-window=right,60%'

GOPATH=/home/q/go/bin

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

plugins=(
        z
        git
        fzf
        sudo
        vi-mode
        zsh-autosuggestions
        zsh-syntax-highlighting
)

ZVM_SYSTEM_CLIPBOARD_ENABLED=true

ZVM_CLIPBOARD_COPY_CMD="wl-copy"
ZVM_CLIPBOARD_PASTE_CMD="wl-copy paste -n"

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
# autoload -U compinit && compinit
# fpath+=~/.zfunc; autoload -Uz compinit; compinit

source "$ZSH"/oh-my-zsh.sh

# bindkey -v
# export EDITOR="nvim"
# autoload edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line
#
# export VI_MODE_SET_CURSOR=true
#
# function zle-keymap-select {
#         if [[ ${KEYMAP} == vimcd ]]; then
#                         echo -ne "\e[2 q"
#                 else
#                         echo -ne "\e[6] q"
#         fi
# }
# zle -N zle-keymap-select
#
# function zle-line-init() {
#         zle -K viins
#         echo -ne "\e[6 q"
# }
# zle -N zle-line-init
#
# function vi-yank-clipboard {
#         zle vi-yank
#         echo "$CUTBUFFER" | pbcopy -i
# }
# zle -N vi-yank-clipboard
# bindkey -M vicmd "y" vi-yank-clipboard
#
# In case a command is not found, try to find the package that has it

function command_not_found_handler {
        local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
        printf 'zsh: command not found: %s\n' "$1"
        local entries=( '${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"}' )
        if (( ${#entries[@]} )) ; then
                printf "${bright}$1${reset} may be found in the following packages:\n"
                local pkg
                for entry in "${entries[@]}" ; do
                        local fields=( "${(0)entry}" )
                        if [[ "$pkg" != "${fields[2]}" ]] ; then
                                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
                        fi
                        printf '    /%s\n' "${fields[4]}"
                        pkg="${fields[2]}"
                done
        fi
        return 127
}

# Detect the AUR wrapper
if pacman -Qi yay &>/dev/null ; then
        aurhelper="yay"
elif pacman -Qi paru &>/dev/null ; then
        aurhelper="paru"
fi

function in {
        local -a inPkg=("$@")
        local -a arch=()
        local -a aur=()

        for pkg in "${inPkg[@]}"; do
                if pacman -Si "$pkg" &>/dev/null; then
                        arch+=("$pkg")
                else
                        aur+=("$pkg")
                fi
        done

        if [[ ${#arch[@]} -gt 0 ]]; then
                sudo pacman -S "${arch[@]}"
        fi

        if [[ ${#aur[@]} -gt 0 ]]; then
                "$aurhelper" -S "${aur[@]}"
        fi
}

# Helpful aliases
alias           l='ls --format=single-column'
alias          ls='ls -lhc --color'
alias          un='$aurhelper -Rns'
alias          up='$aurhelper -Syu'
alias          pl='$aurhelper -Qs'
alias          pa='$aurhelper -Ss'
alias          pc='$aurhelper -Sc'
alias          po='$aurhelper -Qtdq | $aurhelper -Rns -'
alias           S='sudo pacman -S'

alias        tarx='tar xzvf $(date +"%y-%m-%d_%H-%M-%S.tar.gz")'
alias        tarc='tar czvf $(date +"%y-%m-%d_%H-%M-%S.tar.gz")'
alias          sz='clear && source ~/.zshrc && clear'
alias          sb='clear && source ~/.bashrc && clear'
alias           t='tmux'
alias     yayfind='$aurhelper -Slq | fzf --border-label="yay" --multi --preview "$aurhelper -Si {1}" | xargs -ro $aurhelper -S'
alias     pacfind='pacman -Slq | fzf --multi --border-label="pacman" --preview "pacman -Si {1}" | xargs -ro sudo pacman -S'
alias      rmfind='pacman -Qq | fzf --border-label="remove" --multi --preview "pacman -Qi {1}" | xargs -ro sudo pacman -Rns'

alias         nvz='nvim ~/.config/.zshrc'
alias         fzf='fzf -m --preview="bat --color=always {}"'

alias           2='hyprctl dispatch exit'
alias           1='reboot'
alias           0='shutdown now'
alias           .='exec Hyprland'
# alias .=' /usr/lib/plasma-dbus-run-session-if-needed \
#         /usr/bin/startplasma-wayland'

# Handy change dir shortcuts
alias          ..='cd ..'
alias         ...='cd ../..'
alias          .3='cd ../../..'
alias          .4='cd ../../../..'
alias          .5='cd ../../../../..'
alias    start_12='/usr/lib/jvm/java-8-openjdk/jre/bin/java -Xmx1024M -Xms1024M -jar forge-1.12.2-14.23.5.2860.jar nogui'
alias    start_21='/usr/lib/jvm/java-23-openjdk/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui'
alias    start_20='/usr/lib/jvm/java-24-openjdk/bin/java -Xmx6144M -Xms1024M -jar fabric-server-mc.1.20.1-loader.0.16.10-launcher.1.0.1.jar nogui'

# Git aliases
alias        dots='git add --all && git commit --allow-empty-message -m "" && git push'
alias          ga='git add --all'
alias          gc='git commit -m 1'
alias          gp='git push'
alias          lg='lazygit'

# create git repo
repo() {
        git init
        git add --all
        git commit --allow-empty-message -m ""
        git branch -M main
        git remote add origin  "$0"
        git push -u origin main
}

# FFmpeg aliases
mp3() {
        ffmpeg -i "$1" -q:a 0 -map a "$1.mp3"
}

# Compile and run C/C++ file
crun() {
        if [[ -z "$1" ]]; then
                return 1
        fi

        local src="$1"
        local outfile="${src}.out"

        if [[ "$src" == *.cpp ]]; then
                clang++ -std=c++23 -O3 -fsanitize=address,undefined,leak "$src" -o "$outfile" && ./"$outfile"
        elif [[ "$src" == *.c ]]; then
                clang -O3 -fsanitize=address,undefined,leak "$src" -o "$outfile" && ./"$outfile"
        else
                echo "Unsupported file type: $src"
                return 1
        fi
}

# Yazi wrapper
y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
}

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

EDTOR='nvim'

source <(fzf --zsh)

HISTSIZE=10000
HISTFILE=~/.zsh_histrory
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu-no
zstyle ':fzf-tab:complete:cd*' fzf-preview 'ls --color $realpath'

eval "$(zoxide init zsh)"
eval "$(zoxide init --cmd cd zsh)"

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/bin

bindkey -s "^p" 'yayfind \n'
bindkey -s "^z" 'zi \n'
bindkey -s "^h" 'cd \n'
bindkey -s "^k" 'clear \n'
bindkey -s "^l" 'l \n'
bindkey -s "^f" 'fg \n'
# bindkey -s "^\\ " 'n \n'
# bindkey -s "^\\ " 'y \n'
bindkey -s "^\\ " 'fzf \n'
bindkey -s "^n" 'nvim \n'
bindkey -s "^y" 'y \n'
bindkey -s "^[g" 'dots \n'
bindkey -s "^[b" 'btm \n'
bindkey -s "^[z" 'sz \n'
bindkey -s "^[t" 'tmux attach \n'
bindkey -s "^[u" 'up \n'

# if [[ -n "$ZSH_DEBUGRC" ]]; then
#         zprof
# fi

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        mkdir -p ~/.cache
        exec Hyprland > ~/.cache/hyprland.log 2>&1
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/q/.lmstudio/bin"
# End of LM Studio CLI section
