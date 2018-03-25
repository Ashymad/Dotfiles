function msg1
	set_color -o blue
	echo -n ":: "
	set_color normal
	set_color -o
	echo $argv
	set_color normal
end

function msg2
	set_color -o green
	echo -n "==> "
	set_color normal
	set_color -o
	echo $argv
	set_color normal
end

function msg3
	set_color -o brblue
	echo -n "  -> "
	set_color normal
	set_color -o
	echo $argv
	set_color normal
end
