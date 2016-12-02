# Story: As a developer, I can add all of my Tasks to a TaskList.
# Hint: A TaskList has-many Tasks
# Story: As a developer with a TaskList, I can get the completed items.
# Story: As a developer with a TaskList, I can get the incomplete items.

# Story: As a developer, I can add items with due dates to my TaskList.
# Hint: Consider keeping items with due dates separate from the other items.
# Story: As a developer with a TaskList, I can list all the not completed items that are due today.
# Story: As a developer with a TaskList, I can list all the not completed items in order of due date.
# Story: As a developer with a TaskList with and without due dates, I can list all the not completed items in order of due date, and then the items without due dates.

require 'rspec'
require_relative 'task_list'

describe "TaskList" do

  it "can be made" do
    my_tasklist = TaskList.new
    expect{my_tasklist}.to_not raise_error
  end

  it "can have multiple tasks" do
    my_tasklist = TaskList.new
    my_task = Task.new "Clean the dishes"
    my_task1 = Task.new "Do laundry"
    my_task2 = Task.new "Mop the floor"
    my_tasklist.add_task(my_task)
    my_tasklist.add_task(my_task1)
    my_tasklist.add_task(my_task2)
    expect(my_tasklist.list).to be_a Array
    expect(my_tasklist.list.length).to eq 3
    expect(my_tasklist.list).to eq [my_task, my_task1, my_task2]
  end

  it "can get completed tasks" do
    my_tasklist = TaskList.new
    my_task = Task.new "Clean the dishes"
    my_task1 = Task.new "Do laundry"
    my_task2 = Task.new "Mop the floor"
    my_task.done = true
    my_tasklist.add_task(my_task)
    my_tasklist.add_task(my_task1)
    my_tasklist.add_task(my_task2)
    expect(my_tasklist.all_completed).to be_a Array
    expect(my_tasklist.all_completed.length).to eq 1
    expect(my_tasklist.all_completed).to eq [my_task]
    expect{my_task1.done = true}.to change{my_tasklist.all_completed}.from([my_task]).to([my_task, my_task1])
  end

  it "can get incomplete tasks" do
    my_tasklist = TaskList.new
    my_task = Task.new "Clean the dishes"
    my_task1 = Task.new "Do laundry"
    my_task2 = Task.new "Mop the floor"
    my_task.done = true
    my_tasklist.add_task(my_task)
    my_tasklist.add_task(my_task1)
    my_tasklist.add_task(my_task2)
    expect(my_tasklist.all_incomplete).to be_a Array
    expect(my_tasklist.all_incomplete.length).to eq 2
    expect(my_tasklist.all_incomplete).to eq [my_task1, my_task2]
    expect{my_task1.done = true}.to change{my_tasklist.all_incomplete}.from([my_task1,my_task2]).to([my_task2])
  end

  it "can add multiple DueDateTasks to TaskList" do
    my_tasklist = TaskList.new
    my_task = Task.new "Clean"
    my_due_date_task1 = DueDateTask.new("Hw", 2012, 3, 4)
    my_due_date_task2 = DueDateTask.new("Jog", 2013, 3, 10)
    my_tasklist.add_task(my_task)
    my_tasklist.add_task(my_due_date_task1)
    my_tasklist.add_task(my_due_date_task2)
    expect(my_tasklist.list).to eq [my_task, my_due_date_task1, my_due_date_task2]
  end

  it "can list all the not completed items that are due today" do
    my_tasklist = TaskList.new
    today = Date.today
    my_task = Task.new "Something"
    my_due_date_task1 = DueDateTask.new("Hw", 2012, 3, 4)
    my_due_date_task2 = DueDateTask.new("Jog", 2013, 3, 10)
    my_due_date_task3 = DueDateTask.new("Help", 2001, 5, 19)
    my_due_date_task4 = DueDateTask.new("Learn", today.year, today.month, today.day)

    my_due_date_task2.done = true
    my_tasklist.add_task(my_task)
    my_tasklist.add_task(my_due_date_task1)
    my_tasklist.add_task(my_due_date_task2)
    my_tasklist.add_task(my_due_date_task3)
    my_tasklist.add_task(my_due_date_task4)

    expect(my_tasklist.incomplete_due_today).to eq [my_due_date_task4]
  end

  it "can sort list of incomplete item by due date" do
    my_tasklist = TaskList.new
    today = Date.today
    my_task = Task.new "Something"
    my_due_date_task1 = DueDateTask.new("Hw", 2012, 3, 4)
    my_due_date_task2 = DueDateTask.new("Jog", 2013, 3, 10)
    my_due_date_task3 = DueDateTask.new("Help", 2001, 5, 19)
    my_due_date_task4 = DueDateTask.new("Learn", today.year, today.month, today.day)

    my_due_date_task2.done = true
    my_tasklist.add_task(my_task)
    my_tasklist.add_task(my_due_date_task1)
    my_tasklist.add_task(my_due_date_task2)
    my_tasklist.add_task(my_due_date_task3)
    my_tasklist.add_task(my_due_date_task4)

    expect(my_tasklist.sort_incomplete_by_due_date).to eq [my_due_date_task3, my_due_date_task1, my_due_date_task4]
  end

  it "can sort incomplete tasks in order of due date, then items without due date" do
    my_tasklist = TaskList.new
    today = Date.today
    my_task = Task.new "Something"
    my_task1 = Task.new "Watch"
    my_due_date_task1 = DueDateTask.new("Hw", 2012, 3, 4)
    my_due_date_task2 = DueDateTask.new("Jog", 2013, 3, 10)
    my_due_date_task3 = DueDateTask.new("Help", 2001, 5, 19)
    my_due_date_task4 = DueDateTask.new("Learn", today.year, today.month, today.day)

    my_due_date_task2.done = true
    my_tasklist.add_task(my_task)
    my_tasklist.add_task(my_due_date_task1)
    my_tasklist.add_task(my_due_date_task2)
    my_tasklist.add_task(my_due_date_task3)
    my_tasklist.add_task(my_due_date_task4)
    my_tasklist.add_task(my_task1)

    expect(my_tasklist.sort_all_incomplete).to eq [my_due_date_task3, my_due_date_task1, my_due_date_task4, my_task, my_task1]
  end

  it "can list all incomplete due this month" do
    my_tasklist = TaskList.new
    today = Date.today
    my_task = Task.new "Task without a due date"
    my_due_date_task1 = DueDateTask.new("First take due", 2016, 03, 01)
    my_due_date_task2 = DueDateTask.new("Second take due", 2016, 05, 01)
    my_due_date_task3 = DueDateTask.new("Third take due", today.year, today.month, today.day)
    my_due_date_task4 = DueDateTask.new("Fourth take due", 2016, 12, 20)
    my_anniversary1 = Anniversary.new("First anniversary due", 2015, 05, 20)
    my_anniversary2 = Anniversary.new("Second anniversary due", 2010, 12, 14)
    my_anniversary3 = Anniversary.new("Third anniversary due", 2012, 12, 03)
    my_anniversary4 = Anniversary.new("Third anniversary due", 2003, 12, 01)

    my_due_date_task3.done = true

    my_tasklist.add_task(my_task)
    my_tasklist.add_task(my_due_date_task1)
    my_tasklist.add_task(my_due_date_task2)
    my_tasklist.add_task(my_due_date_task3)
    my_tasklist.add_task(my_due_date_task4)
    my_tasklist.add_task(my_anniversary1)
    my_tasklist.add_task(my_anniversary2)
    my_tasklist.add_task(my_anniversary3)
    my_tasklist.add_task(my_anniversary4)

    my_anniversary1.next_anniversary_date
    my_anniversary2.next_anniversary_date
    my_anniversary3.next_anniversary_date
    my_anniversary4.next_anniversary_date

    expect(my_tasklist.due_current_month).to eq [my_anniversary3, my_anniversary2, my_due_date_task4, my_anniversary4]
  end

  it "can list all incomplete by this month then those without due dates" do
    my_tasklist = TaskList.new
    today = Date.today
    my_task = Task.new "Task without a due date"
    my_due_date_task1 = DueDateTask.new("First take due", 2016, 03, 01)
    my_due_date_task2 = DueDateTask.new("Second take due", 2016, 05, 01)
    my_due_date_task3 = DueDateTask.new("Third take due", today.year, today.month, today.day)
    my_due_date_task4 = DueDateTask.new("Fourth take due", 2016, 12, 20)
    my_anniversary1 = Anniversary.new("First anniversary due (last year)", 2015, 05, 20)
    my_anniversary2 = Anniversary.new("Second anniversary due (6 years ago)", 2010, 12, 14)
    my_anniversary3 = Anniversary.new("Third anniversary due (this year)", 2012, 12, 03)
    my_anniversary4 = Anniversary.new("Third anniversary due (this year)", 2003, 12, 01)

    my_due_date_task3.done = true

    my_tasklist.add_task(my_task)
    my_tasklist.add_task(my_due_date_task1)
    my_tasklist.add_task(my_due_date_task2)
    my_tasklist.add_task(my_due_date_task3)
    my_tasklist.add_task(my_due_date_task4)
    my_tasklist.add_task(my_anniversary1)
    my_tasklist.add_task(my_anniversary2)
    my_tasklist.add_task(my_anniversary3)
    my_tasklist.add_task(my_anniversary4)

    my_anniversary1.next_anniversary_date
    my_anniversary2.next_anniversary_date
    my_anniversary3.next_anniversary_date
    my_anniversary4.next_anniversary_date

    expect(my_tasklist.all_incomplete_this_month).to eq [my_anniversary3, my_anniversary2, my_due_date_task4, my_anniversary4, my_task]
  end




end


# Story: As a developer with a TaskList with and without due dates and yearly recurring dates, I can list all the not completed items in order of due date and yearly dates for the current month.
#
# Story: As a developer with a TaskList with a collection of items with and without due dates and yearly recurring dates, I can list all the not completed items in order of due date and yearly dates for the current month, then the items without due dates.
