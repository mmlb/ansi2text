#!/usr/bin/env bash

t=$(
	tr -d '\n' <<-'EOF'
		foo\e[1mbar\e[0m\n
		\e[?2004l
		\e]0;title1\e\\
		\e]4;16;rgb:0/0/0\e\\
		\e]0;title2\a
		\n
	EOF
)

want="foobar

"

if false; then
	{
		echo t:
		echo "$t" | hexdump -C
		echo printfd:
		printf "$t" | hexdump -C
		echo want:
		printf "$want" | hexdump -C
	} >&2
fi

echo 1..2

ret=0
if diff -u <(printf "$t" | ./ansi2txt.py | hexdump -C) <(echo -n "$want" | hexdump -C) &>/dev/null; then
	echo "ok 1 - ansi2txt.py"
else
	echo "not ok 1 - ansi2txt.py"
	diff -u <(printf "$t" | ./ansi2txt.py | hexdump -C) <(echo -n "$want" | hexdump -C) | sed 's|^|\t|'
	ret=1
fi

if diff -u <(printf "$t" | ./ansi2txt.sh | hexdump -C) <(echo -n "$want" | hexdump -C) &>/dev/null; then
	echo "ok 2 - ansi2txt.sh"
else
	echo "not ok 2 - ansi2txt.sh"
	diff -u <(printf "$t" | ./ansi2txt.sh | hexdump -C) <(echo -n "$want" | hexdump -C) | sed 's|^|\t|'
	ret=1
fi

exit $ret
