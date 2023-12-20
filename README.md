# VldMail

VldMail is a ruby wrapper for the C language [libvldmail](https://github.com/dertuxmalwieder/libvldmail) email validation library. I built it to explore the ruby C API,to get my hands dirty building a ruby C gem, and to document how to do this for other ruby developers who might be curious about building C extensions.

N.B.: This is UNTESTED, ALPHA QUALITY CODE. Sorry for shouting. But if you landed here, because you want to use libvldmail in your ruby app, the author of libvldmail suggests using [SWIG](https://www.swig.org). Do that.

## Recommendations for Learning About Mixing Ruby and C

tl;dr Know ruby. Learn C. Read over some of the listed resources. Read the commits in this repo from initial commit to HEAD.

Prerequisites: You should know ruby well. Basic familiarity with C is sufficient to get started. If you have no prior exposure to C, just start with [K&R](https://en.wikipedia.org/wiki/The_C_Programming_Language), 2nd ed. It's one of those rare programming books that's both useful and a good read.

Here are some resources I found helpful:
- [Creating extension libraries for Ruby](https://docs.ruby-lang.org/en/master/extension_rdoc.html)
- [Writing Ruby C extensions: Part 1](http://tenderlovemaking.com/2009/12/18/writing-ruby-c-extensions-part-1.html)
- [Writing Ruby C Extensions: Part 2](http://tenderlovemaking.com/2010/12/11/writing-ruby-c-extensions-part-2.html)
- [Writing your very own Ruby extension with C](https://web.archive.org/web/20070222125445/http://nanoblog.ath.cx/?module=readmore&id=8)
- [Awesome C](https://github.com/oz123/awesome-c)

Start at ruby-lang.org and read for a high-level understanding. Then try the blog posts. Then go back to ruby-lang.org to answer your questions. Awesome C is where I found libvldmail. Maybe you'll find something there to play with.

Then there's this project: I wrote each commit to document the process of making the gem -- sort of a really slow motion live-coding presentation. (And like any live-coding, this one includes a few missteps....) So head over to Commits and work from the bottom up.

Yeah, this could probably be a blog post, but I haven't finished rewriting my blog engine yet. ;-)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vldmail-rb', git: 'https://github.com/jlcapps/vldmail-rb.git', branch: 'master'
```

And then execute:

    $ bundle install

Or follow instructions beneath *Development*.

## Usage

```ruby
require 'vldmail'

validation = VldMail::Validation.new('foo@example.com')
validation.email
  => 'foo@example.com'
validation.success?
  => true
validation.message
  => ''
validation = VldMail::Validation.new('foo@example@com')
validation.success?
  => false
validation.message
  => 'One @ is more than enough.'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## License

The gem is available as open source under the terms of the [MIT-0 License](https://opensource.org/licenses/MIT-0).
