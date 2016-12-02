require 'date'
require_relative 'task'

class DueDateTask < Task

  #Inherits @title(String), @done(Boolean), @description(String) from Task object
  def initialize(title, year, month, day)
    #title is initialized as input from parent object, Task.
    super(title)
    @year = year
    @month = month
    @day = day
    #Creates a Date object that takes in initialized values of year, month, day
    @due_date = Date.new(@year, @month, @day)
  end

  #Setter method that changes due_date
  def update_due_date(year, month, day)
    @year = year
    @month = month
    @day = day
    @due_date = Date.new(@year, @month, @day)
  end

  #Getter method for due date
  def due_date
    @due_date
  end

  #Shows title, done?, description, and due date
  #Pulls info method from parent object, Task. Adds @due_date to the Task info.
  def info_plus_due_date
    "#{info} \nDue on: #{@due_date}"
  end

end


# my_date = DueDateTask.new("Hw", 1111, 6, 12)
# puts my_date.due_date
#
# my_date.update_due_date(2015, 3, 1)
# puts my_date.due_date
