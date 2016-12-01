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

  #Shows title, done?, description, and anniversary date
  def show_anniversary_info
    next_anniversary_date
    "#{info} \nAnniversary: #{@due_date}"
  end

end
