require_relative 'due_date_task'

class Anniversary < DueDateTask

  #Inherits @title, @done, @description from Task
  #Inherits @due_date from DueDateTask
  def initialize(title, year, month, day)
    super(title, year, month, day)
  end

  #Will update next anniversary year when called if the anniversay day
  #is before today's date
  def next_anniversary_date
    while (@due_date <= Date.today)
      @due_date = Date.new(@year += 1, @month, @day)
    end
  end

  #Setter method that updates @due_date for Anniversary object
  #Runs next_anniversary_date to update due date based on today's date
  def update_anniversary(year, month, day)
    @year = year
    @month = month
    @day = day

    @due_date = Date.new(@year, @month, @day)
    next_anniversary_date
  end

  #Shows title, done?, description, and anniversary date
  def info_plus_anniversary
    next_anniversary_date
    "#{info} \nAnniversary: #{@due_date}"
  end

end
