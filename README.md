# i18n-light

### Light implementation of i18n.

A light implementation to add internationalization into your apps.

## Setup

Install this gem using the classic command :

```bash
gem install i18n-light
```

Then, import it into your project :

```ruby
require 'i18n-light'
```

## Playing around

```ruby
# 🔧 STEP ONE : define our strings
# Use a hash with this format :
# :locale => { :key => value
#            OR
#            :category_key => { values }
#          }

strings = {
    fr => {
        hello: "Bonjour !",
        switch_locale: "Changement de langue...",
        homepage: {
          welcome: "Bienvenue sur {site} !",
          howareyou: "Comment allez-vous, {user} ?"
        }
    },
    en: {
        hello: "Hello !",
        switch_locale: "Switching locale...",
        homepage: {
          # We don't know the site name, so we let formatting adding it
          welcome: "Welcome to {site} !",
          howareyou: "How are you, {user} ?"
        }
    }
}

# 💡 STEP TWO - Your turn !

# We register the i18n class with strings definition and fallback locale in case of fail
i18n = I18n.new(strings, :en, nil, true)

# We didn't define a locale, so the program will output in the fallback locale

# Don't forget to include the formatting params !
puts i18n.t(:homepage, :welcome, {site: "Github"})
puts i18n.t(:switch_locale)

# We can change the locale at any point of the script !
i18n.locale = :fr
puts i18n.t(:hello)

# We're gonna play with wrong code, to show warnings and errors

# Asking for an unknown string
puts i18n.t(:test, :ele)

# Defining an unknown formatting parameter
puts i18n.t(:homepage, :welcome, {site: "Github", page: "Accueil"})

# Letting unfilled parameters
puts i18n.t(:homepage, :howareyou)

# Defining an unknown locale
i18n.locale = :es
puts i18n.t(:hello)
```
