# Story: As a developer, I can create a DueDateTask, which is-a Task that has-a due date.
# Hint: Use the built-in Ruby Date class
# Story: As a developer, I can print an item with a due date with labels and values.
# Hint: When implementing to_s, use super to call to_s on the super class.

require 'rspec'
require_relative 'due_date_task'

describe "DueDateTask" do
  it "can be made" do
    expect{DueDateTask.new("Hw", 2016, 3, 5)}.to_not raise_error
  end

  it "must have a due date" do
    my_due_date_task = DueDateTask.new("Hw", 2016, 3, 5)
    expect(my_due_date_task.due_date.class).to be Date
  end

  it "returns a due date" do
    my_due_date_task = DueDateTask.new("Hw", 2016, 12, 4)
    expect(my_due_date_task.show_due_date).to eq "Title: Hw\nDescription: \nDone: false \nDue on: 2016-12-04"
  end
end
