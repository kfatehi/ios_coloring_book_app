class Drawing
  attr_accessor :paths, :path_colors, :needs_to_render

  def initialize
    @paths = []
    @path_colors = []
    @needs_to_render = false
  end

  def initWithCoder(decoder)
    self.init
    self.paths = decoder.decodeObjectForKey("paths")
    self.path_colors = decoder.decodeObjectForKey("path_colors")
    self
  end

  def encodeWithCoder(encoder)
    encoder.encodeObject(self.paths, forKey: "paths")
    encoder.encodeObject(self.path_colors, forKey: "path_colors")
  end
end