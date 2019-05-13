# frozen_string_literal: true

class CnabsController < ApplicationController
  before_action :set_cnab, only: %i[show edit update destroy]

  # GET /cnabs
  # GET /cnabs.json
  def index
    @cnabs = current_user.cnabs.all.page params[:page]
  end

  # GET /cnabs/1
  # GET /cnabs/1.json
  def show
    @transactions = @cnab.transactions.page params[:page]
  end

  # GET /cnabs/new
  def new
    @cnab = current_user.cnabs.new
  end

  # POST /cnabs
  # POST /cnabs.json
  def create
    @cnab = current_user.cnabs.new(cnab_params)

    respond_to do |format|
      if @cnab.save
        format.html { redirect_to @cnab, notice: 'Cnab was successfully created.' }
        format.json { render :show, status: :created, location: @cnab }
      else
        format.html { render :new }
        format.json { render json: @cnab.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cnab
    @cnab = current_user.cnabs.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cnab_params
    params.require(:cnab).permit(:report)
  end
end
