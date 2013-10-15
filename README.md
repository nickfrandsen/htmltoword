# Ruby Html to word Gem [![Code Climate](https://codeclimate.com/github/nickfrandsen/htmltoword.png)](https://codeclimate.com/github/nickfrandsen/htmltoword) [![Build Status](https://travis-ci.org/nickfrandsen/htmltoword.png)](https://travis-ci.org/nickfrandsen/htmltoword)

This simple gem allows you to create MS Word docx documents from simple html documents. This makes it easy to create dynamic reports and forms that can be downloaded by your users as simple MS Word docx files.

Add this line to your application's Gemfile:

    gem 'htmltoword'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install htmltoword

## Usage

### Standalone

```ruby
require 'htmltoword'

my_html = '<html><head></head><body><p>Hello</p></body></html>'
file = Htmltoword::Document.create my_html, file_name
```

### With Rails

```ruby
# Add mime-type in /config/initializers/mime_types.rb:
Mime::Type.register "application/vnd.openxmlformats-officedocument.wordprocessingml.document", :docx

# Add docx reponder in your controler
def show
  respond_to do |format|
    format.docx do
      file = Htmltoword::Document.create params[:docx_html_source], "file_name.docx"
      send_file file.path, :disposition => "attachment"
    end
  end
end
```

```javascript
  // OPTIONAL: Use a jquery click handler to store the markup in a hidden form field before the form is submitted.
  // Using this strategy makes it easy to allow users to dynamically edit the document that will be turned
  // into a docx file, for example by toggling sections of a document.
  $('#download-as-docx').on('click', function () {
    $('input[name="docx_html_source"]').val('<!DOCTYPE html>\n' + $('.delivery').html());
  });
```

## Features

All standard html elements are supported and will create the closest equivalent in wordml. For example spans will create inline elements and divs will create block like elements.

### Highlighting text

You can add highlighting to text by wrapping it in a span with class h and adding a data style with a color that wordml supports (http://www.schemacentral.com/sc/ooxml/t-w_ST_HighlightColor.html) ie:

```html
<span class="h" data-style="green">This text will have a green highlight</span>
```

### Page breaks

To create page breaks simply add a div with class -page-break ie:

```html
<div class="-page-break"></div>
````

## Contributing / Extending

Word docx files are essentially just a zipped collection of xml files and resources.
This gem contains a standard empty MS Word docx file and a stylesheet to transform arbitrary html into wordml.
The basic functioning of this gem can be summarised as:

1. Transform inputed html to wordml.
2. Unzip empty word docx file bundled with gem and replace its document.xml content with the new transformed result of step 1.
3. Zip up contents again into a resulting .docx file.

For more info about WordML: http://rep.oio.dk/microsoft.com/officeschemas/wordprocessingml_article.htm

Contributions would be very much appreciated.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

(The MIT License)

Copyright © 2013:

* Cristina Matonte

* Nicholas Frandsen
