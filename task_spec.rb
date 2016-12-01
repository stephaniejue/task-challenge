# Story: As a developer, I can create a Task.
# Story: As a developer, I can give a Task a title and retrieve it.
# Story: As a developer, I can give a Task a description and retrieve it.
# Story: As a developer, I can mark a Task done.
# Story: As a developer, when I print a Task that is done, its status is shown.
# Hint: Implement to_s have it return the features of a Task with labels (for instance, "Title: Buy Food Description: Bananas, milk").

require 'rspec'
require_relative 'task'

describe "Task" do
  my_task = Task.new "Homework"

  it "can be made" do
    expect{my_task}.to_not raise_error
  end

  it "can have a title and retrieve it" do
    expect(my_task.title).to be_a String
    expect(my_task.title).to eq "Homework"
    expect(my_task.title = "Go for jog").to eq "Go for jog"
  end

  it "can have a description and retrieve it" do
    my_task.description = "This is the description of my homework"
    expect(my_task.description).to be_a String
    expect(my_task.description).to eq "This is the description of my homework"
    expect(my_task.description = "I am going to run really fast").to eq "I am going to run really fast"
  end

  it "can be marked as done" do
    expect(my_task.done?).to eq false
    expect(my_task.done = true).to eq true
  end

  it "can show task title, description and status" do
    my_task.title = "Christmas Decorating"
    my_task.description = "Decorate the tree for Christmas"
    my_task.done = true
    expect(my_task.info).to eq "Title: Christmas Decorating\nDescription: Decorate the tree for Christmas\nDone: true"
  end

end
