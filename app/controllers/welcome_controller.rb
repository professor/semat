class WelcomeController < ApplicationController

  def index
    @version = EssenceVersion.first    
  end


  def state
    @version = EssenceVersion.first
  end
  
end  