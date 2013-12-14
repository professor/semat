class Api::V1::VersionsController < ApplicationController


  def show
     @version = EssenceVersion.where(:name => params[:name]).first
  end

  def index
     @versions = EssenceVersion.all
  end


end
