class Task
  def initialize(title)
    @title = title
    @done = false
  end

  def title=(title)
    @title = title
  end

  def title
    @title
  end

  def description=(description)
    @description = description
  end

  def description
    @description
  end

  def done?
    @done
  end

  def done=(done)
    @done = done
  end

  def info
    "Title: #{@title}\nDescription: #{@description}\nDone: #{@done}"
  end

end
