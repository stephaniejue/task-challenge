require 'date'
require_relative 'task'

class DueDateTask < Task

  #Inherits @title, @done, @description from Task
  def initialize(title, year, month, day)
    super(title)
    @due_date = Date.new(year, month, day)
  end

  #Getter function for due date
  def due_date
    @due_date
  end

  #Shows title, done?, description, and due date
  def show_due_date
    "#{info} \nDue on: #{@due_date}"
  end

end
