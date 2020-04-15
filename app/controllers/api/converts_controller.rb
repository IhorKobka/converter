class Api::ConvertsController < ApplicationController
  def create
    render json: ::ConvertService.new(request.params[:convert]).call
  end

  private

  def convert_params
    params.require(:convert).permit(keys: [])
  end
end
