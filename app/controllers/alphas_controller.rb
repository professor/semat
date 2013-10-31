class AlphasController < ApplicationController


  def show
    @alpha = Alpha.find(params[:id])
  end

  def index
    @version = EssenceVersion.first
  end

end
