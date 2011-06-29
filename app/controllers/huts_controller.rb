class HutsController < ApplicationController
  respond_to :html, :js
  before_filter :load_hut, :except => [:index]
  
  def index
    respond_with(@huts = Hut.includes(:point))
  end
  
  def show
    respond_with(@hut)
  end
  
  private
  
  def load_hut
    @hut = Hut.find(params[:id])
  end
  
end
