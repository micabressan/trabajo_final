class MyController < ApplicationController
      def options
        options = {}
        available_option_keys = [:first_option, :second_option, :third_option]
        all_keys = params.keys.map(&:to_sym)
        set_option_keys = all_keys & available_option_keys
        set_option_keys.each do |key|
          options[key] = params[key]
        end
        options
      end
    end