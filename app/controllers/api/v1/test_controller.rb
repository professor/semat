class Api::V1::TestController < ApplicationController


  def get
    puts "TestController:get"
    puts params
    @response = params
  end

  def post
    puts "TestController:post"
    puts params
    @response = params
  end

end
