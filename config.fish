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

#set -U fish_greeting ""
function fish_greeting
    set hour (date +"%H")

    echo ""
    if test $hour -ge 6 -a $hour -lt 13
        echo "Good morning, sir. I trust you’ve finally decided to rejoin the land of the living."
        echo "Should I prepare your suit, or would you like more time to recover?"
    else if test $hour -ge 13 -a $hour -lt 20
        echo "Master, I see you’ve decided to take a *personal day*."
        echo "No heroic deeds or world-saving activities planned, I assume?"
    else if test $hour -ge 20 -a $hour -lt 24
        echo "Still at it, sir? Your work ethic is impressive, though I must recommend sleep eventually."
        echo "Even Iron Man needs to recharge."
    else if test $hour -ge 0 -a $hour -lt 6
        echo "Burning the midnight oil, are we, sir?"
        echo "If I may ask, is something weighing on your mind—or perhaps just another brilliant idea?"
    end
end
#------ONLY FOR WSL--------
#function go_home
#   cd ~/../../mnt/c/
 #   commandline -f repaint
 #end

 #bind \ch go_home


