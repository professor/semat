class AlphasController < ApplicationController

#  before_filter :authenticate_user!


  def show
    @alpha = Alpha.find(params[:id])
  end

  def index
    @version = EssenceVersion.first
  end

  def simple_index
    index
  end

end
