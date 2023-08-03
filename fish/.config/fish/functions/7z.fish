function 7z
	if test "$argv[1]" = "xn"
		/usr/bin/7za x "$argv[2]" -o(basename $argv[2] | sed 's/\.[^.]*$//')
	else
		/usr/bin/7za $argv
	end
end

