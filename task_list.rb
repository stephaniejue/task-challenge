require_relative 'anniversary'

class TaskList

  #@task_list will hold all Task, DueDateTasks, and Anniversary objects
  def initialize
    @task_list = []
  end

  #Adds object to @task_list based on user input
  def add_task(task)
    @task_list << task
  end

  #Getter method for tasks list
  def list
    @task_list
  end

  #Returns an array of all completed tasks
  def all_completed
    completed_tasks = []
    @task_list.each do |task|
      if task.done?
        completed_tasks << task
      end
    end
    completed_tasks
  end

  #Returns an array of all incompleted tasks
  def all_incomplete
    incomplete_tasks = []
    @task_list.each do |task|
      if !task.done?
        incomplete_tasks << task
      end
    end
    incomplete_tasks
  end

  #Returns an array where it is of class DueDateTask or Anniversary and is due today
  #Uses all_incomplete method to get all incomplete tasks
  def incomplete_due_today
    incomplete_due_today = []
    all_incomplete.each do |task|
      if (task.class == DueDateTask || task.class == Anniversary) && (task.due_date == Date.today)
        incomplete_due_today << task
      end
    end
    incomplete_due_today
  end

  #Returns a sorted array with DueDateTasks objects by due date
  #Uses all_incomplete method to get all incomplete tasks
  def sort_incomplete_by_due_date
    incomplete_tasks = []
    all_incomplete.each do |task|
      if (task.class == DueDateTask || task.class == Anniversary)
        incomplete_tasks << task
      end
    end

    #'!' means that sort will update original array
    incomplete_tasks.sort! do |a_task, b_task|
      a_task.due_date <=> b_task.due_date
    end

    incomplete_tasks
  end

  #Combines sorted list of objects with due dates and the remaining incomplete
  #tasks using a union so that it only gets unique tasks
  def sort_all_incomplete
    sort_incomplete_by_due_date | all_incomplete
  end

  #Returns sorted array of incomplete tasks by due date for the current month
  #Uses sort_incomplete_by_due_date to get all incomplete tasks with DueDateTask
  #and Anniversary objects.
  def due_current_month
    due_current_month = []
    sort_incomplete_by_due_date.each do |task|
      if (task.due_date.month == Date.today.month)
        due_current_month << task
      end
    end
    #'!' means that sort will update original array
    due_current_month.sort! do |a_task, b_task|
      a_task.due_date <=> b_task.due_date
    end
  end

  #Returns a list of only incomplete Task objects without due dates
  def incomplete_without_due_date
    incomplete_no_due_date = []
    @task_list.each do |task|
      if (!task.done? && task.class == Task)
        incomplete_no_due_date << task
      end
    end
    incomplete_no_due_date
  end

  #Combines sorted list of DueDateTask and Anniversary objects by due date for
  #current month and Task objects(which have no due date value). Uses a union
  #to avoid having duplicate items
  def all_incomplete_this_month
    due_current_month | incomplete_without_due_date
  end

end
