function reverse_search
	set command (tac ~/.local/share/fish/fish_history | grep '^- cmd: ' | cut -c 8- | fzf)
	commandline -r "$command"
end

