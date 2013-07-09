## Another Markdown editor gem for rails 3. 

![Edit](http://pic.yupoo.com/nickelchen/CZ6aVUgw/csiy1.png)
![Preview](http://pic.yupoo.com/nickelchen/CZ6aXPaT/uMQxx.png)

Heavily inspired by [mdeditor](http://ghosertblog.github.io/mdeditor/)

Use the following libraries:

 1. [pagedown](https://code.google.com/p/pagedown/) as the markdown parser, 
 2. [pagedown-extra](https://github.com/jmcmanus/pagedown-extra) as the extra plugins for pagedown
 3. [google-code-prettify](https://code.google.com/p/google-code-prettify/) as the code highlighter.



## Usage
 1. user with simple_form
     
  ```
= f.input :content, as: :mdtext_area, input_html: { :rows => 10 }
  ```
 2. view helper

  ```
= mdtext_area_tag :content, '' , rows: 10
  ```
 3. form builder

  ```
= f.mdtext_area :content, rows: 10
  ```

## Start from a sample

 rails new myapp, cd myapp

 add dependencies to Gemfile

    gem 'mdeditor_rails', path: '/Users/nickelchen/work/workspaces/my_gems/mdeditor_rails'
    gem 'twitter-bootstrap-rails', '2.1.9'

 bundle install

 install bootstrap

    rails generate bootstrap:install static

 install mdeditor_rails, add this to application.js

    //= require 'mdeditor_rails'

 add this to application.css ( you know the meaning of this code )

     *= require mdeditor_rails

 generate a scaffold

    rails g scaffold Post title:string content:text

 modify posts/_form.html.erb from `f.text_area` to `f.mdtext_area`

 there you go