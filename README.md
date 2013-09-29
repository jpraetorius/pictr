pictr
=====

Small ruby based tool to generate nice static-HTML-only galleries from a bunch of images


Usage
-----

Call with `ruby pictr.rb`

```
Usage: pictr.rb -T <title> [options]

available options:
    -T, --title TITLE                title of the gallery to produce
    -t, --target-dir DIR             directory in which pictr should store the generated files (default: site/)
    -s, --source-dir DIR             directory from which pictr reads your pictures (default: images/)
    -a, --author AUTHOR              Name of the author/creator of the pictures (default: <empty>)
    -d, --description DESCRIPTION    Description of the gallery (shown on the start page) (default: <empty>)
    -p, --pattern PATTERN            Comma separated file patterns for scanning input directory for picture files (default: '*.jpg')
    -h, -?, --help                   Show this message
    --version                        Show version
```
