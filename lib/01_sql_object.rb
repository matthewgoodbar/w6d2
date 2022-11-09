require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    @query ||= DBConnection.execute2(<<-SQL)
      SELECT 
        * 
      FROM 
        #{self.table_name}
      LIMIT 0
    SQL

    @query.first.map {|el| el.to_sym}
    
  end

  def self.finalize!
    self.columns.each do |col|
      define_method("#{col}=".to_sym) do |val|
        instance_variable_set("@#{col}", val)
        self.attributes[col] = val
      end

      define_method(col) do
        instance_variable_get("@#{col}")
      end
    end
  end

  def self.table_name=(val)
    @table_name = val
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
    @table_name
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})

  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
