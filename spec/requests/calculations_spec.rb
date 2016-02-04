# encoding: utf-8
require 'rails_helper'

describe 'Calculations API' do
  
  describe 'GET /calculations' do
    context 'when happy path conditions are met' do

      it 'returns 200' do
        calculator = double('calculator', execute: true, valid?: true, result: {})
        allow(Calculator).to receive(:new).and_return(calculator)
        get '/calculations'
        expect(response.code).to eq('200')
      end

      it 'returns expected result' do
        get '/calculations', { current_amount: 100, serving_size: 2, regular_hitches: 2, youth_hitches: 2}

        expect(response.code).to eq('200')
        expect(JSON.parse(response.body)).to eq({ "servings_needed" => 154, "pounds_needed" => 308 })
      end

    end


  end

end

