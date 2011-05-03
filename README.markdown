# URL Validator #

---

URL validator makes possible check URI with different charset like: www.詹姆斯.com . For each setted variable to check, it generates the dynamic method called `variable_normalized`, which return internationalized format of URI. For exmaple `www.詹姆斯.com => www.xn--8ws00zhy3a.com`. This gem is using [addressable](http://github.com/sporkmonger/addressable) gem for internationalizing and beyond regexp for checking valid URI. See in spec kind of valid/invalid URI.

## Installation ##

---

Include the gem in your Gemfile:

    gem "url_validator", "~> 0.0.3"

Or as a plugin:

    rails plugin install git://github.com/zdenal/url_validator

## Usage ##

---

In your class:

    class User

      attr_accessor :website
      validates_url :website

    end

Then somewhere in code:

    @user.website = 'www.詹姆斯.com'
    @user2.website = 'website.com'
    @user.website_normalized       # =>  www.xn--8ws00zhy3a.com
    @user2.website_normalized      # =>  website.com
    @user.valid?                   # => true
    @user2.valid?                  # => true
    @user.website                  # => http://www.詹姆斯.com
    @user2.website                 # => http://website.com

Url validator automaticly prefill scheme '**http://**' (by schemes options - see below) if is missing in URI.

## Options ##

---

 * `:allow_blank => false/true`          default = false. The same princip like in others validations.
 * `:allow_nil => false/true` >          default = false. The same princip like in others validations.
 * `:message => 'Some custom message'`   default is: "is not a valid URL". A custom error message.
 * `:schemes => ['http', 'https',...]`   default = ['http', 'https']. Array of URI schemes to validate against. If checked URI missing scheme, then the first scheme of this array is chosen for prefill URI.
 *  `:prefferred_scheme => 'ftp://'`     default is the first item from `schemes` array. If setted, then the validator prefill the checked URI with this scheme if missing some scheme.
 *  `:if/:unless => .....`               the same like in others validations.


If preffered scheme is 'ftp://' and URI is with some scheme **http://website.com**, then after valid is URI **http://website.com**.

If preffered scheme is 'ftp://' and URI is without some scheme **website.com**, then after valid is URI **ftp://website.com**.

For constriction URI schemes, use option `:scheme => ['ftp']`, then **http://website.com** will not valid and **website.com** will valid and prefilled to **ftp://website.com**.


## Tests ##

---

You can find more specification for valid/invalid checking URI in spec folder inside tests.

    rake spec  # run tests.

