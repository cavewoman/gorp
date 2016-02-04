# encoding: utf-8
require 'rails_helper'

describe 'Calculator' do

  it 'works with proper input' do
    expect(Calculator.new(current_amount: 0, serving_size: 1, regular_hitches: 1, youth_hitches: 1)).to be_valid
  end

  it 'requires serving size' do
    expect(Calculator.new(current_amount: 0, serving_size: 0, regular_hitches: 1, youth_hitches: 1)).not_to be_valid
    expect(Calculator.new(current_amount: 0, regular_hitches: 1, youth_hitches: 1)).not_to be_valid
  end

  it 'requires at least one kind of hitch' do
    expect(Calculator.new(current_amount: 0, serving_size: 1, regular_hitches: 0, youth_hitches: 0)).not_to be_valid
    expect(Calculator.new(current_amount: 0, serving_size: 1, regular_hitches: 1, youth_hitches: 0)).to be_valid
    expect(Calculator.new(current_amount: 0, serving_size: 1, regular_hitches: 1)).to be_valid
    expect(Calculator.new(current_amount: 0, serving_size: 1)).not_to be_valid
  end

  describe '#execute' do
    
    context 'when happy path conditions are met' do
      
      it 'sets result' do
        calculator = Calculator.new(current_amount: 100, serving_size: 2, regular_hitches: 2, youth_hitches: 2)

        expect(calculator.execute).to eq(true)
        expect(calculator.result).to eq({servings_needed: 154, pounds_needed: 308})
      end

    end

  end



end
