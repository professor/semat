class Api::V1::AlphasController < ApplicationController


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
