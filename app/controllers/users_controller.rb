# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = if params[:id]
              User.find(params[:id])
            else
              current_user
            end

    # @user = User.find(params[:id])
    redirect_to root_path, alert: 'Access denied.' unless @user == current_user
    if current_user.current_phone.nil?
      if current_user.phones.size == 1
        flash[:warning] = "You should #{view_context.link_to('confirm phone number', confirm_phone_path(current_user.phones.last), data: { loads_in_ajax_modal: true })}"
      else
        flash[:warning] = "You should #{view_context.link_to('set phone number', new_phone_path, data: { loads_in_ajax_modal: true })}"
      end
    else
      if current_user.currency.nil?
        flash[:warning] = "You should #{view_context.link_to('choose your coins', new_currency_path(current_user.phones.last), data: { loads_in_ajax_modal: true })}"
        # redirect_to root_path, :alert => "Access denied."
      end
      # {view_context.link_to("profile page", link_path)}, and edit it!"
      # {link_to 'Add Phone', new_phone_path, data: {loads_in_ajax_modal: true}}"

      # render :partial => 'layouts/modal'
      # render layout: 'modal', data: { modal: true }
      #
    end
  end
end
