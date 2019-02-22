# i18n-light - A light implementation to add internationalization into your apps.
#   Guide and source code : https://github.com/exybore/i18n-light
#   Documentation : https://www.rubydoc.info/gems/i18n-light
#
# @author exybore

# Exception to handle unknown locale
class UnknownLocale < StandardError  
end  

# The i18n core class
class I18n
  
  # @return [String, Symbol] the locale selection
  attr_accessor :locale
  
  # Initialize the i18n class
  #
  # @param strings [Hash] all the strings
  # @param fallback_locale [String, Symbol] the locale to use if any is set
  # @param locale [String, Symbol] set a locale
  # @param warning [Boolean] enable warnings during runtime
  def initialize strings, fallback_locale, locale = nil, warnings = false
    @warnings = warnings
    @strings = strings
    @fallback_locale = fallback_locale
  end
  
  # Get a string in the selected locale
  #
  # @param key [String, Symbol] key of the string to return
  # @param subkey [String, Symbol] sub-key for categories
  # @param params [Hash] parameters for formatting
  #
  # @raise [UnknownLocale] if the selected locale is unknown
  # @return the requested string
  def t key, subkey = nil, params = {}
    
    # locale selection
    locale = @locale.nil? ? @fallback_locale : @locale
    t = @strings[locale]
    if t.nil?
      raise Unknownlocale, "[i18n] error : unknown locale"
    end
    
    # key selection
    t = t[key]
    if t.nil?
      puts "[i18n] warning : unknown key #{key}" if @warnings
      return
    end
    
    # subkey selection (if exists)
    t = t[subkey] unless subkey.nil?
    
    # formatting parameters
    params.each do |name, value|
      puts "[i18n] warning : unknown parameter #{name}" if @warnings && t !~ /{#{name}}/
      t.sub!("{#{name}}", value)
    end
    puts "[i18n] warning : unfilled formatting parameters" if @warnings && t =~ /{.+}/
    
    # returning the string
    t
  end
end
