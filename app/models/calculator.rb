require 'active_model'

class Calculator
  include ActiveModel::Model
  extend ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Conversion

  validates :current_amount, presence: true
  validates :serving_size, presence: true
  validates :regular_hitches, presence: true
  validates :youth_hitches, presence: true
  validate :check_ss
  validate :hitches

  attr_accessor :current_amount
  attr_accessor :serving_size
  attr_accessor :regular_hitches
  attr_accessor :youth_hitches
  attr_accessor :regular_crew
  attr_accessor :reg_hitch_duration
  attr_accessor :youth_crew
  attr_accessor :youth_hitch_duration
  attr_accessor :result

  def initialize(attributes={})
    attributes = defaults.merge(attributes.symbolize_keys)
    @current_amount = attributes[:current_amount].to_i
    @serving_size = attributes[:serving_size].to_i
    @regular_hitches = attributes[:regular_hitches].to_i
    @youth_hitches = attributes[:youth_hitches].to_i
    @regular_crew = attributes[:regular_crew]
    @reg_hitch_duration = attributes[:reg_hitch_duration]
    @youth_crew = attributes[:youth_crew]
    @youth_hitch_duration = attributes[:youth_hitch_duration]
    @result = {}
  end

  def execute
    begin
      current_servings = current_servings_available
      rhs = regular_hitch_servings
      yhs = youth_hitch_servings
      all_servings = rhs + yhs
      needed = all_servings - current_servings
      @result = { servings_needed: needed, pounds_needed: needed*serving_size }
      true
    rescue StandardError => ex
      errors.add(:current_amount, 'Something went wrong')
    end
  end

  def current_servings_available
    return current_amount/serving_size
  end

  def regular_hitch_servings
    (regular_hitches * regular_crew)*reg_hitch_duration
  end

  def youth_hitch_servings
    (youth_hitches * youth_crew)*youth_hitch_duration
  end

  private

  def defaults
    { current_amount: 0, serving_size: 0, reqular_hitches: 0, youth_hitches: 0, regular_crew: 8, reg_hitch_duration: 9, youth_crew: 6, youth_hitch_duration: 5 }
  end

  def check_ss
    unless serving_size > 0
      errors.add(:serving_size, 'Serving size must be greater than 0')
    end
  end

  def hitches
    unless (regular_hitches && regular_hitches > 0) || (youth_hitches && youth_hitches > 0)
      errors.add(:hitches, 'You need to have at least one kind of hitch')
    end
  end

end
