# frozen_string_literal: true

# App controller class
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  include AjaxModalRails::Controller

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end


    def after_sign_in_path_for(_resource)
      if params[:redirect_to].present?
        store_location_for(resource, params[:redirect_to])
      else
        if current_user.current_phone.nil? # lопишу проверку
          after_signup_path(:add_phone)
        else
          dashboard_path
        end
      end
    end


    # def after_sign_in_path_for(resource)
    #   puts "
    #
    #   CURRENT USER: #{current_user.id}
    #   C. USER PHONE: #{current_user.current_phone}
    #
    #   "
    #
    #   if current_user.current_phone.nil?
    #     store_location_for(step1_wizard_path, params[:redirect_to])
    #   else
    #     super
    #   end
    #
    # end


end
