require './core/db'


class ActiveRecord

  attr_accessor :new

  attr_accessor :condition, :order, :group, :limit

  def initialize
    @new = true

    @condition = @order = @group = @limit = ''
  end

  def attrs
    []
  end

  def primary_key
    ''
  end


  def self.find
    self.new
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

  def limit(limit)
    @limit = limit
    self
  end

  def all
    sql = "SELECT * FROM #{table}"
    if @condition != ''
      sql += ' WHERE ' + @condition
    end
    if @order != ''
      sql += ' ORDER BY ' + @order
    end
    if @group != ''
      sql += ' GROUP BY ' + @group
    end
    if @limit != ''
      sql += ' LIMIT ' + @limit.to_s
    end

    items = []

    results = $db.exec(sql)
    results.each do |item|
      todo = Todo.new
      todo.new = false

      attrs = todo.attrs

      attrs.each do |attr|
        todo.send(attr + '=', item.fetch(attr, ''))
      end

      items.append todo
    end
    items
  end

  def one id
    where "id=#{id}"
    limit 1
    res = all
    if res.length > 0
      res[0]
    else
      nil
    end
  end

  def save
    attributes = attrs
    if @new
      sql = "INSERT INTO #{table} "


      sql += '( '
      set = '('

      attributes.each do |attr|
        if attr != primary_key
          unless (instance_variable_get '@' + attr).nil?
            sql += "#{attr},"
            set += "'"
            set += instance_variable_get '@' + attr
            set += "',"
          end
        end
      end
      sql = sql.chomp(',')
      set = set.chomp(',')
      set += ')'
      sql += ")  VALUES #{set} RETURNING #{primary_key}"
    else
      sql = "UPDATE #{table} "
      sql += ' SET '

      attributes.each do |attr|
        if attr != primary_key
          sql += "#{attr} = '"
          unless (instance_variable_get '@' + attr).nil?
            sql += instance_variable_get '@' + attr
            sql += "',"
          end
        end
      end
      sql = sql.chomp(',')
      sql += " WHERE #{primary_key} = "
      sql += instance_variable_get '@' + primary_key
    end

    res = $db.exec(sql)
    if @new
      instance_variable_set '@' + primary_key, res
    end
  end

  def delete
    unless @new
      sql = "DELETE FROM #{table} WHERE #{primary_key} = "
      sql += instance_variable_get '@' + primary_key
      $db.exec(sql)
    end
  end
end
