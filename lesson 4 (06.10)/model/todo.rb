require './core/activerecord'
class Todo < ActiveRecord
  attr_accessor :id, :title, :created_at, :done

  def initialize
    super
  end

  def table
    'todo'
  end

  def attrs
    ["id", "title", "created_at", "done"]
  end

  def primary_key
    "id"
  end
end


