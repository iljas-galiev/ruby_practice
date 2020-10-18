require './db'

class ActiveRecord

  attr_accessor :new

  attr_accessor :condition, :order, :group, :join

  def initialize
    @new = true

    @condition = @order = @group = @join = ''
  end

  def self.find
    Todo.new
  end

  def where(condition)
    @condition = condition
    self
  end

  def order(order)
    @order = order
    self
  end

  def group(group)
    @group = group
    self
  end

  def join(join)
    @join = join
    self
  end

  def all
    sql = "SELECT * FROM #{table}"
    if @condition != ''
      sql += " WHERE " + @condition
    end
    if @join != ''
      sql += @join
    end
    if @order != ''
      sql += " ORDER BY " + @order
    end
    if @group != ''
      sql += " GROUP BY " + @group
    end

    $db.exec(sql)
  end

  def save

  end
end

class Todo < ActiveRecord
  attr_accessor :id, :title, :created_at, :done

  def initialize
    super
  end
  def table
    'todo'
  end
end


class Product < ActiveRecord
  def initialize
    super
  end
  def table
    'product'
  end
end