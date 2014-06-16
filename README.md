# rack-secure-upload

[![Gem Version](https://badge.fury.io/rb/rack-secure-upload.svg)](http://badge.fury.io/rb/rack-secure-upload) [![Build Status](https://travis-ci.org/dtaniwaki/rack-secure-upload.svg?branch=master)](https://travis-ci.org/dtaniwaki/rack-secure-upload) [![Coverage Status](https://coveralls.io/repos/dtaniwaki/rack-secure-upload/badge.png)](https://coveralls.io/r/dtaniwaki/rack-secure-upload)

Upload files securely

## Installation

Add the rack-secure-upload gem to your Gemfile.

```ruby
gem "rack-secure-upload"
```

And run `bundle install`.

### Rack App

```ruby
require 'rack-secure-upload'
use Rack::SecureUpload::Middleware, :fsecure
run MyApp
```

### Rails App

In `config/application.rb`

```ruby
module MyApp
  class Application < Rails::Application
    config.middleware.use Rack::DevMark::Middleware, :fsecure
  end 
end
```

## AntiVirus Softwares

### F-Secure

1. Get [license](http://www.f-secure.com/en/web/business_global/trial)
2. Install the package

```bash
wget http://download.f-secure.com/webclub/f-secure-linux-security-10.00.60.tar.gz
tar xvzf f-secure-linux-security-10.00.60.tar.gz
sudo ./f-secure-linux-security-10.00.60/f-secure-linux-security-10.00.60
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2014 Daisuke Taniwaki. See [LICENSE](LICENSE) for details.
