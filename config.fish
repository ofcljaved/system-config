if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
export PATH="$PATH:/opt/nvim/"

function fzf_dir
    set current_dir (pwd)
    set dir (find . -type d -not -path '*/.*' -not -path '*/node_modules*' | fzf)
    if test -n "$dir"
        cd "$dir"
        if test -n "$TMUX"
            tmux new-window
        else
            tmux
        end
        cd "$current_dir"
    end
end

bind \cf fzf_dir

#------ONLY FOR WSL--------
function go_home
    cd ~/../../mnt/c/
    commandline -f repaint
end

bind \ch go_home
