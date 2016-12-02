# Story: As a developer, I can create a to do item for an anniversary (a yearly recurring event) .
# Hint: An Anniversary has a month and a day.
# Hint: An Anniversary is a special kind of DueDateTask where the due date changes depending on the current date (override the due_date method to return the next annivesary date).
#
# Story: As a developer, I can print an item for an anniversary with field labels and values.
#

require 'rspec'
require_relative 'anniversary'

describe "Anniversary" do
  it "can be made" do
    expect{Anniversary.new("Homework", 2016, 12, 1)}.to_not raise_error
  end

  it "inherits DueDateTask" do
    my_anniversary = Anniversary.new("Homework", 2016, 12, 1)
    expect(my_anniversary.due_date.class).to be Date
  end

  it "overrides due date with next anniversary date" do
    today = Date.today
    my_anniversary = Anniversary.new("Homework", 2016, 6, 1)
    my_anniversary2 = Anniversary.new("Homework", 2016, 12, 1)
    my_anniversary.next_anniversary_date
    my_anniversary2.next_anniversary_date
    expect(my_anniversary.due_date).to eq Date.new(2017, 6, 01)
    expect(my_anniversary2.due_date).to eq Date.new(2017, 12, 1) #test against actual today date
  end

  it "can update anniversary due date" do
    my_anniversary = Anniversary.new("Wedding", 2015, 3, 10)

    #Changes anniversay due_date from 2015-03-10 to 2013-10-08
    #Due date then should be updated to 2017-10-08 since the changed anniversary is in the past
    expect{my_anniversary.update_anniversary(2013, 10, 8)}.to change{my_anniversary.due_date}.from(Date.new(2015, 3, 10)).to(Date.new(2017, 10, 8))
  end

  it "can print all the info (title, description, done, due, anniversary)" do
    my_anniversary = Anniversary.new("Wedding", 2016, 6, 1)
    expect(my_anniversary.info_plus_anniversary).to eq "Title: Wedding\nDescription: \nDone: false \nAnniversary: 2017-06-01"
  end

end
