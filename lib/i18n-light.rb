# Exception to handle unknown locale
class UnknownLocale < StandardError  
end  

# i18n class, the center of the program
class I18n
  
  # @return [String, Symbol] the locale selection
  attr_accessor :locale
  
  # Initialize the i18n class
  #
  # @param strings [Hash] all the strings
  # @param fallback_locale [Strings, Symbol] the locale to use if any is set
  # @param locale [Strings, Symbol, nil] set a locale (optional)
  # @param warning [Boolean] enable warnings during runtime (default: false)
  def initialize strings, fallback_locale, locale = nil, warnings = false
    @warnings = warnings
    @strings = strings
    @fallback_locale = fallback_locale
  end
  
  # Get a string in the configured locale
  #
  # @param key [String, Symbol] key of the string to return
  # @param subkey [String, Symbol, nil] subkey for categories (optional)
  # @param params [Hash, nil] params for formatting
  # @return the requested key
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
