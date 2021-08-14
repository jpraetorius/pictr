# pictr

Small ruby based tool to generate nice static HTML/CSS only galleries from a bunch of images.


## Usage

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


## Tweaking

### Favicons

Favicons are taken as-is from `static/favicon`. Replace all the files you find in there with your own ones
to provide your own favicon.

### Social Network previews

The templates for both the individual and the individual picture pages provide metadata for preview
snippets in social networks so links to the pages get rendered with a rich preview.
You can set the following options besides `author` and `title` to automatically generate the correct content
in the meta-tags:

```
    --description DESCRIPTION           short description of the contents of the gallery (default: <empty>)
    --twitter_handle TWITTER_HANDLE     your Twitter handle (default: <empty>)
    --url URL                           The URL you want to publish this gallery on (default: <empty>)
```

### Templates

You can also fully customise the display of the pages, by replacing the templates. There's only two `erb` Files
used for generating the overview and picture detail pages.

   * `templates/page.erb` is the template of the overview page that shows thumbnails and links to the individual picture pages
   * `templates/image.erb` is the template of an individual picture.

Both templates have a corresponding Ruby class (`lib/page.rb` and `lib/img.rb` respectively) that hold the available values and methods used in filling the template. 

All assets found in `static` are copied verbatim to the output and can be referenced from the templates.