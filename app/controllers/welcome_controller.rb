class WelcomeController < ApplicationController

  def index
    @version = EssenceVersion.first    
  end
  
end  