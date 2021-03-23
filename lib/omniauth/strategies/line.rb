# frozen_string_literal: true

require 'omniauth-oauth2'
require 'json'
require 'jwt'

module OmniAuth
  module Strategies
    class Line < OmniAuth::Strategies::OAuth2
      option :name, 'line'
      option :scope, 'profile openid email'

      option :client_options, {
        site: 'https://access.line.me',
        authorize_url: '/oauth2/v2.1/authorize',
        token_url: '/oauth2/v2.1/token'
      }

      # host changed
      def callback_phase
        options[:client_options][:site] = 'https://api.line.me'
        super
      end

      def callback_url
        # Fixes regression in omniauth-oauth2 v1.4.0 by https://github.com/intridea/omniauth-oauth2/commit/85fdbe117c2a4400d001a6368cc359d88f40abc7
        options[:callback_url] || (full_host + script_name + callback_path)
      end

      uid { raw_info['userId'] }

      info do
        {
          name: raw_info['displayName'],
          image: raw_info['pictureUrl'],
          description: raw_info['statusMessage'],
          email: email
        }
      end

      # Require: Access token with PROFILE permission issued.
      def raw_info
        @raw_info ||= JSON.parse(access_token.get('v2/profile').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

      def email
        JWT.decode(access_token.params['id_token'], options[:client_secret]).first['email']
      rescue StandardError
        puts 'Please sure your permissions.'
        puts 'https://developers.line.biz/en/docs/line-login/integrate-line-login/#applying-for-email-permission'
        nil
      end
    end
  end
end
