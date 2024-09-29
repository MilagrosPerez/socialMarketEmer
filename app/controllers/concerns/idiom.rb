module Idiom
  extend ActiveSupport::Concern

  included do

    #Logica para que detecte el idioma del navegador y setee el idioma
    # around_action :switch_locale
    # def switch_locale(&action)
    #   I18n.with_locale(locale_from_header, &action)
    # end
    # private
    # def locale_from_header
    #   request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
    # end

    before_action :set_locale


    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options
      { locale: I18n.locale }
    end

  end
end