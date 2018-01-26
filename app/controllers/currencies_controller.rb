# frozen_string_literal: true

# CRUD class controller for choose cryptocurrency
class CurrenciesController < ApplicationController
  before_action :set_currency, only: %i[show edit update destroy]

  # GET /currencies
  # GET /currencies.json
  def index
    @currencies = Currency.all
  end

  # GET /currencies/1
  # GET /currencies/1.json
  def show; end

  # GET /currencies/new
  def new
    @currency = Currency.new
  end

  # GET /currencies/1/edit
  def edit; end

  # POST /currencies
  # POST /currencies.json
  def create
    @currency = Currency.new(currency_params)
    @currency.user_id = current_user.id
    respond_to do |format|
      if @currency.save
        format.html { redirect_to current_user }
        format.json
      else
        format.html { render :new }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /currencies/1
  # PATCH/PUT /currencies/1.json
  def update
    respond_to do |format|
      if @currency.update(currency_params)
        format.html { redirect_to current_user }
        format.json
      else
        format.html { render :edit }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /currencies/1
  # DELETE /currencies/1.json
  def destroy
    @currency.destroy
    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_currency
      @currency = Currency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def currency_params
      params.require(:currency).permit(:bitcoin, :lightcoin, :dogecoin)
    end
end