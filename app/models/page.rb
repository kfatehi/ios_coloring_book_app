class Page
  attr_reader :number, :book, :image_path

  def initialize book, number
    @book = book
    @number = number
    @image_path = File.join(App.resources_path, @book.name, "#{self.number}.png")
  end

  def image
    UIImage.alloc.initWithContentsOfFile self.image_path
  end
end