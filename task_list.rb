require_relative 'anniversary'

class TaskList

  #@list will hold all Task, DueDateTasks, and Anniversary objects
  def initialize
    @list = []
  end

  #Adds object to @list based on user input 
  def add_task(task)
    @list << task
  end

  #Getter method for tasks list
  def list
    @list
  end

  #Returns an array of all completed tasks
  def show_completed
    completed = []
    @list.each do |task|
      if task.done?
        completed << task
      end
    end
    completed
  end

  #Returns an array of all incompleted tasks
  def show_incomplete
    incomplete = []
    @list.each do |task|
      if !task.done?
        incomplete << task
      end
    end
    incomplete
  end

  #Returns an array where it is of class DueDateTask or Anniversary and is due today
  #Uses show_incomplete method to get all incomplete tasks
  def show_incomplete_due_today
    incomplete_due_today = []
    show_incomplete.each do |task|
      if (task.class == DueDateTask || task.class == Anniversary) && (task.due_date == Date.today)
        incomplete_due_today << task
      end
    end
    incomplete_due_today
  end

  #Returns a sorted array with DueDateTasks objects by due date
  #Uses show_incomplete method to get all incomplete tasks
  def sort_incomplete_by_due_date
    sorted = []
    show_incomplete.each do |task|
      if (task.class == DueDateTask || task.class == Anniversary)
        sorted << task
      end
    end
    sorted.sort! do |a, b|
      a.due_date <=> b.due_date
    end

    sorted
  end

  #Combines sorted list of objects with due dates and the remaining incomplete
  #tasks using a union so that it only gets one of each item
  def sort_all_incomplete
    sort_incomplete_by_due_date | show_incomplete
  end

  #Returns sorted array of incomplete tasks by due date for the current month
  #Uses sort_incomplete_by_due_date to get all incomplete tasks with DueDateTask
  #and Anniversary objects.
  def show_due_by_month
    due_by_month = []
    sort_incomplete_by_due_date.each do |item|
      if (item.due_date.month == Date.today.month)
        due_by_month << item
      end
    end
    due_by_month.sort! do |a, b|
      a.due_date <=> b.due_date
    end
  end

  #Returns a list of only incomplete Task objects
  def show_incomplete_without_due_date
    incomplete = []
    @list.each do |task|
      if (!task.done? && task.class == Task)
        incomplete << task
      end
    end
    incomplete
  end

  #Combines sorted list of DueDateTask and Anniversary objects by due date for
  #current month and Task objects(which have no due date value). Uses a union
  #to avoid having duplicate items
  def show_all_incomplete_this_month
    show_due_by_month | show_incomplete_without_due_date
  end

end
