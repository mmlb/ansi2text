# ansi2txt

ansi to plain text converter

## Related

Here are some related projects

- [colorized-logs](https://github.com/kilobyte/colorized-logs)
- [strip-ansi-cli](https://github.com/chalk/strip-ansi-cli)

## Acknowledgements

This code base is a translation/port of the `ansi2txt.c` code base from [colorized-logs](https://github.com/kilobyte/colorized-logs) to Python3 and Bash.
This project came about because I liked the original `ansi2txt`'s output but did not want to have to compile it or ship binaries around.
I ported ansi2txt.c → ansi2txt.py but then came across an environment without python so went ansi2txt.py → ansi2txt.sh.

## License

[AGPLv3](https://choosealicense.com/licenses/agpl-3.0/) AND [MIT](https://choosealicense.com/licenses/mit/)

## Running Tests

To run tests, run the following command

```bash
bats ansi2txt.bats
```
