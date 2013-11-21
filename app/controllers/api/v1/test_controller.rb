class Api::V1::TestController < ApplicationController

  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

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
