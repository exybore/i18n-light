<div align="center">
    <h1>i18n-light</h1>
    <h3>A light implementation to add internationalization into your Ruby apps.</h3>
</div>

- [🔧 Setup](#-setup)
  - [Quick installation](#quick-installation)
  - [Gemfile](#gemfile)
  - [Build](#build)
- [⌨ Basic interactions](#-basic-interactions)
  - [Writing the strings](#writing-the-strings)
  - [Defining our i18n core](#defining-our-i18n-core)
  - [Changing locale](#changing-locale)
  - [Printing strings](#printing-strings)
- [💾 Advanced outputing](#-advanced-outputing)
  - [Formatting](#formatting)
- [🔐 License](#-license)

## 🔧 Setup

### Quick installation

If you want to quickly test the library, you can install it using the `install` command of Ruby Gem.

```bash
gem install i18n-light
```

### Gemfile

If you setup the library for medium or big projects, it's recommended to write it in your Gemfile.

```gemfile
gem 'i18n-light', '~> 1.0'
```

After, use again the `install` command, but without the package name.

```bash
gem install
```

### Build

You can also compile it by yourself. First, clone the repository.

```bash
git clone https://github.com/exybore/i18n-light.git  # HTTP
          git@github.com:exybore/i18n-light.git      # SSH
```

Then, build the gemspec file to create the gem.

```bash
gem build ./i18n-light.gemspec
```

Finally, install it on your system.

```bash
gem install ./i18n-light-1.x.x.gem
```

## ⌨ Basic interactions

First of all, we must include the library in our project. That can be achieved really easily with the `require` keyword.

```ruby
require 'i18n-light'

# ...
```

### Writing the strings

To provide multiple locales into our application, we're going to write all the strings the app needs in a single hash, separated in different hashes for each locale.

```ruby
strings = {
    # You can use symbols or strings for keys
    fr: {
        # French strings
    },
    en: {
        # English strings
    },
    # ...
}
```

Now that we defined our locales, we'll complete these hashes with the strings.

```ruby
strings = {
    fr: {
        hello: "Bonjour !"
    },
    en: {
        hello: "Hello !"
    }
}
```

We can even set sub-hashes, for different categories of the application.

```ruby
strings = {
    fr: {
        # ...
        homepage: {
          welcome: "Bienvenue ici !"
        }
    },
    en: {
        # ...
        homepage: {
          welcome: "Welcome here !"
        }
    }
}
```

### Defining our i18n core

Now that our strings are ready, we must create the core object. The initialization method of the `I18n` object can take up to four arguments :

- the strings hash
- the fallback locale
- a locale to use (optional)
- warnings output (default : false)

For example, we take English as fallback locale, any start locale and we disable warnings.

```ruby
i18n = I18n.new(strings, :en, nil, false)
```

### Changing locale

To change the locale during runtime, simply redefine the `locale` attribute of your i18n class.

```ruby
i18n.locale = :fr
```

### Printing strings

Now, we can print our strings. For this, use the `t` method and pass the key of the desired string.

```ruby
puts i18n.t(:hello)
# Output : "Hello !" / "Bonjour !"
```

For strings in categories, just add the sub-key in the parameters.

```ruby
puts i18n.t(:homepage, :welcome)
# Output : "Welcome here !" / "Bienvenue ici !"
```

## 💾 Advanced outputing

### Formatting

Imagine that we want to print the user's name in the middle of the sentence. Instead of creating two separated strings, we'll use formatting. The syntax is really simple : an identifier surrounded by curly brackets.

```ruby
{
    # ...
    user: "User {name}"
}
```

We add it in the method parameters with the value.

```ruby
# We're not in a category, so we let this argument with 'nil'
puts i18n.t(:user, nil, {
    name: "kernoeb"
})
# Example output : "User kernoeb"
```

## 🔐 License

The i18n-light library is under the MIT license. See the [license file](LICENSE) for further informations.
