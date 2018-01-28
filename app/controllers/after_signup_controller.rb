class AfterSignupController < ApplicationController
  include Wicked::Wizard

  steps :add_phone, :validate_phone, :add_coins

  def show
    @user = current_user
    case step
    when :add_phone
      @phone = @user.add_phone
    end
    render_wizard
  end
end
