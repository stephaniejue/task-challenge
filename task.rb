class Task
  def initialize(title)
    #Must pass in title when Task object is created
    @title = title
    #@done defaults to false, meaning task is incomplete
    @done = false
  end

  #Setter method that can reset title
  def title=(title)
    @title = title
  end

  #Getter method that returns title
  def title
    @title
  end

  #Setter method that sets an optional description
  def description=(description)
    @description = description
  end

  #Getter method that returns description
  def description
    @description
  end

  #Getter method that returns state of "done"-ness
  def done?
    @done
  end

  #Setter method for whether task is complete(true => complete; false => incomplete)
  def done=(done)
    @done = done
  end

  #Returns all info contained in a Task object
  def info
    "Title: #{@title}\nDescription: #{@description}\nDone: #{@done}"
  end

end
