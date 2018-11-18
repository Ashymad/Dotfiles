function 7z --wraps 7z
	if test "$argv[1]" = "xn"
		/usr/bin/7z x "$argv[2]" -o(basename $argv[2] | sed 's/\.[^.]*$//')
	else
		/usr/bin/7z $argv
	end
end

