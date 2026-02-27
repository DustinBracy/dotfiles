#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vi=nvim
alias vim=nvim
alias xmr='xmrig -o 127.0.0.1:3333 --huge-pages-jit --randomx-1gb-pages --argon2-impl=SSSE3'
PS1='[\u@\h \W]\$ '

export PATH=$PATH:/home/dustin/go/bin
export EDITOR=nvim
export VISUAL=nvim

