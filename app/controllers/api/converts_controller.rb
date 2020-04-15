class Api::ConvertsController < ApplicationController
  def create
    render json: ::ConvertService.new(request.params[:convert]).call
  end
end
