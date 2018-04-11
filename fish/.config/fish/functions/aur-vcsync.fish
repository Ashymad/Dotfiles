function aur-vcsync
	source ~/.config/fish/utils/pacmsg.fish
	set vcs_list git hg cvs svn bzr
	msg1 "Checking newest commit of repositories..."
	aur srcver ~/.cache/aurutils/sync/*-$vcs_list > /tmp/vcs.tmp 
	msg1 "Comparing to locally installed versions..."
	set updates (aur vercmp -p /tmp/vcs.tmp -d custom-aur)
	if test -z "$updates"
		msg3 "There is nothing to do"
		exit
	end
	for update in $updates
		echo Updating $update...
		aur sync --no-ver \
			--repo custom-aur \
			(echo $update \
				| awk '{print $1}' \
				| sed 's/:$//')
	end
end

