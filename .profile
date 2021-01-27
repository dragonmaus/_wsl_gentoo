# ~/.profile
# User-specific login shell profile

# Enforce `separation of concerns' between login and interactive shells
shell=$(basename $SHELL)
case $- in
(*i*)
	exec $shell -l -c 'exec $shell -i "$@"' $shell "$@"
	;;
esac

# Clean up and augment PATH
path=
ifs=$IFS
IFS=:
for d in ~/bin ~/sbin ~/.cargo/bin ~/.local/bin ~/.local/python/bin $PATH
do
	d=$(readlink -f $d 2> /dev/null || echo $d)
	case ":$path:" in
	(*:$d:*)
		continue
		;;
	esac
	path=$path:$d
done
IFS=$ifs
path=${path#:}

# Set environment
set -a

## Paths
MANPATH=~/.local/share/man:$MANPATH
PATH=$path

## Shell configuration
ENV=~/.shrc

## Global configuration
EDITOR=nvim
HOSTNAME=${HOSTNAME:-$(hostname -s)}

## App-specific configuration
LESS=Ri
LESSHISTFILE=-
PYTHONUSERBASE=~/.local/python
RIPGREP_CONFIG_PATH=~/.config/ripgrep.conf

set +a
