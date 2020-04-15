# frozen_string_literal: true

module ErrorsCatcher
  extend ActiveSupport::Concern

  included do
    rescue_from ConvertError, with: :unprocessable_entity
  end

  private

  def unprocessable_entity(error)
    render json: { error: error }, status: :unprocessable_entity
  end
end
