#!/usr/bin/env bats

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

@test "bash" {
	diff -u <(printf "$t" | ./ansi2txt.sh | hexdump -C) <(echo -n "$want" | hexdump -C)
}

@test "python" {
	diff -u <(printf "$t" | ./ansi2txt.py | hexdump -C) <(echo -n "$want" | hexdump -C)
}
