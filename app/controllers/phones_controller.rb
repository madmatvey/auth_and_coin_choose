class PhonesController < ApplicationController
  before_action :set_phone, only: [:show, :edit, :confirm, :update, :destroy]
  include AjaxModalRails::Controller
  def new
    @phone = Phone.new
    @country_codes=TelephoneNumber::Country.all_countries.map{ |x| [x.country_id, x.country_code] }
  end

  def edit
  end

  def confirm
  end

  def create
    @phone = Phone.new(number: "#{phone_params[:country_code]+phone_params[:number]}")
    @phone.user_id = current_user.id
    respond_to do |format|
      if @phone.save(phone_params)
        @phone.send_validation
        format.html { redirect_to current_user }
        format.json
      else
        format.html { render :edit }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @phone.check_token(params[:confirm_code])
        format.html { redirect_to current_user, notice: 'Phone was successfully confirmed.' }
        format.json
      else
        format.html { render :edit }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phone
      @phone = Phone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_params
      params.require(:phone).permit(:number,:confirm_code,:country_code)
    end

end
