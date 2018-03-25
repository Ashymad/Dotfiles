function aur-vcsync
	source ~/.config/fish/utils/pacmsg.fish
	set vcs_list git hg cvs svn bzr
	echo -n "" > /tmp/vcs.tmp
	msg1 "Checking newest commit of repositories..."
	for vcs in $vcs_list
		set repos ~/.cache/aurutils/sync/*-$vcs
		for repo in $repos
			aur srcver $repo >> /tmp/vcs.tmp 
		end
	end
	msg1 "Comparing to locally installed versions..."
	set updates (aur vercmp -p /tmp/vcs.tmp -d custom-aur)
	for update in $updates
		echo Updating $update...
		aur sync --no-ver \
			--repo custom-aur \
			(echo $update \
				| awk '{print $1}' \
				| sed 's/:$//')
	end
end

