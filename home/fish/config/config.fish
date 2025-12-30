if status --is-login
	fortune|cowsay
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    fish_vi_key_bindings
end

set -g fish_greeting ""
set -x EDITOR nvim
set -x BROWSER librewolf
set -gx NIXPKGS_ALLOW_UNFREE 1

abbr -a v nvim
