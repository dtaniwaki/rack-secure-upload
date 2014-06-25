# rack-secure-upload

[![Gem Version](https://badge.fury.io/rb/rack-secure-upload.svg)](http://badge.fury.io/rb/rack-secure-upload) [![Build Status](https://travis-ci.org/dtaniwaki/rack-secure-upload.svg)](https://travis-ci.org/dtaniwaki/rack-secure-upload) [![Coverage Status](https://coveralls.io/repos/dtaniwaki/rack-secure-upload/badge.png)](https://coveralls.io/r/dtaniwaki/rack-secure-upload)

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
    config.middleware.insert_before ActionDispatch::ParamsParser, Rack::SecureUpload::Middleware, :avast
  end 
end
```

## Options

You can add some options like below.

```ruby
use Rack::SecureUpload::Middleware, :fsecure, {foo: :bar}
```

### fallback

- `proc { |env, params, path| }`
  - use return value of proc
- `:raise`
  - raise `Rack::SecureUpload::InsecureFileError` |
- else
  - return `406`

## AntiVirus Softwares

### Avast

1. Get [license](http://www.avast.com/registration-free-antivirus.php)
2. Install the package

```bash
wget -c http://files.avast.com/files/linux/avast4workstation-1.3.0-1.i586.rpm
sudo yum localinstall avast4workstation-1.3.0-1.i586.rpm
avast -V # Input your license
avast-update
```

### F-Secure

1. Get [license](http://www.f-secure.com/en/web/business_global/trial) (Optional)
2. Install the package

```bash
wget http://download.f-secure.com/webclub/f-secure-linux-security-10.00.60.tar.gz
tar xvzf f-secure-linux-security-10.00.60.tar.gz
sudo ./f-secure-linux-security-10.00.60/f-secure-linux-security-10.00.60
```

## Test this middleware

1. Download [eicar test file](http://www.f-secure.com/virus-info/eicar.com)
2. Upload it

You can try this with [sample app](https://github.com/dtaniwaki/rack-secure-upload-sample-app)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2014 Daisuke Taniwaki. See [LICENSE](LICENSE) for details.
