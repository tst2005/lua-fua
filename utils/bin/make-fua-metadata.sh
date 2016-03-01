#!/bin/sh

allsums="md5sum  sha1sum  sha224sum  sha256sum  sha384sum  sha512sum"

if [ $# -ne 1 ]; then
	echo "Usage: $0 <fua-module>"
	exit 1
fi

if [ ! -e "$1" ]; then
	echo "No such fua module $1"
	exit 1
fi

f="$1";shift
case "$f" in
	*/init.fua) f="$(dirname "$f")" ;;
esac

fua_meta_mkdir() {
	[ -n "$metadir" ] || return
	[ ! -d "$metadir" ] || return
	mkdir -- "$metadir"
}
fua_meta_sums() {
	local f="$1"
	printf -- '%s\n' '--fua meta file--'
	printf -- '%s\n' '-- TODO: find a more secure format than just reading lua code'
	printf 'return {\n'
	for sum in $allsums; do
		printf '\t["%s"] = "%s",\n' "$sum" "$(command "$sum" "$f" |cut -d\  -f1)"
	done
	printf '}\n'
}

fua_file_stuff() {
	local f="$1"
	local metadir="$(dirname "$f")/.$(basename "$f" .fua).meta"
	fua_meta_mkdir
	fua_meta_sums "$f" > "$metadir/sums"
}

fua_dir_stuff() {
	local f="$1"
	local metadir="$f/.init.meta"
	fua_meta_mkdir
	fua_meta_sums "$f/init.fua" > "$metadir/sums"
}

## it's a file ##
if [ -f "$f" ]; then
	case "$f" in
		*.fua) ;;
		*)
			echo "it's not a fua module"
			exit 1
	esac
	fua_file_stuff "$f"
elif [ -d "$f" ]; then
	fua_dir_stuff "$f"
else
	echo "ERROR: it seems not a file and not a directory!"
	exit 1
fi
