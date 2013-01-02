class Book
  attr_reader :name
  def initialize name
    @name = name
  end

  def page number
    Page.new(self, number)
  end
end