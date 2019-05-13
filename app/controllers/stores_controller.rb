class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  # GET /stores
  # GET /stores.json
  def index
    @stores = current_user.stores.includes(:transactions).page params[:page]
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @transactions = @store.transactions.page params[:page]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = current_user.stores.find(params[:id])
    end
end
