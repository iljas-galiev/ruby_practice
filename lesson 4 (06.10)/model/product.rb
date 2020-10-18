require './core/activerecord.rb'

class Product < ActiveRecord
  attr_reader :id
  attr_accessor :name
  def initialize
    super
  end
  def table
    'product'
  end
end
