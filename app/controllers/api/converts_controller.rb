class Api::ConvertsController < ApplicationController
  def create
    render json: ::ConvertService.new(convert_params).call
  end

  private

  def convert_params
    params.require(:convert).permit(data: [:country, :school, :class, :student_counts], skipped_keys: [])
  end
end
