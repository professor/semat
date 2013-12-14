class VersionsController < ApplicationController


  def index
      @versions = EssenceVersion.all
  end

  def show
    @version = EssenceVersion.where(:name => params[:name]).first
  end

end
