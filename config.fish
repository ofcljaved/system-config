if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

function add_to_path
    if not contains $argv $PATH
        set -gx PATH $argv $PATH
    end
end

function rm 
    set args
    set ski_confirmation 0

    for arg in $argv
         if test $arg = "-y"
            set ski_confirmation 1
        else
            set args $args $arg
        end
    end

    if test $ski_confirmation -eq 0
        echo "Are you sure you want to delete? Use -y to confirm. Files:  $args"
        echo -n "Type 'yes' to proceed: "
        read confirmation

        if test $status -ne 0
            echo "Aborted"
            return 1
        end

        if test $confirmation != "yes"
            echo "Aborted"
            return 1
        end
    end

    command rm $args
end

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

# Global variables
set -gx NVM_DIR "$HOME/.nvm"
set -gx BUN_INSTALL "$HOME/.bun"
set -gx PNPM_HOME "$HOME/.local/share/pnpm"

add_to_path "/opt/nvim/bin"
add_to_path $BUN_INSTALL/bin 
add_to_path "/usr/local/go/bin" 
add_to_path "$HOME/.local/share/solana/install/active_release/bin" 
add_to_path "$PNPM_HOME" 
add_to_path "$HOME/.cargo/bin"
