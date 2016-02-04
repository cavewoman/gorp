class CalculationsController < ApplicationController

  def index
    @calculator = Calculator.new(calculator_params)
    if @calculator.valid?
      if @calculator.execute
        render json: @calculator.result, status: 200
      else
        render json: { error: @calculator.errors }, status: 500
      end
    else
      render json: { error: @calculator.errors }, status: 401 
    end
  end


  private

  def calculator_params
    params.slice('current_amount', 'serving_size', 'regular_hitches', 'youth_hitches')
  end
  
end
