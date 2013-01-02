class DrawView < UIView  
  attr_accessor :brush_size, :brush_color, :needs_to_redraw, :has_input,
                :buffer_image, :mid1, :mid2, :cache_brush_size, :previous_point1,
                :previous_point2, :paths, :path_colors, :current_point

  def self.build(page)
    draw_view = new
    draw_view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth
    draw_view.contentMode = UIViewContentModeScaleToFill
    draw_view.backgroundColor = UIColor.clearColor
    draw_view.drawing = page.drawing
    draw_view
  end

  def drawing=(drawing)
    @drawing = drawing
    @paths = @drawing.paths
    @path_colors = @drawing.path_colors
    @drawing.needs_to_render = true
  end

  def render_drawing
    UIGraphicsBeginImageContext(frame.size)
    @buffer_image.drawInRect(CGRectMake(0, 0, frame.size.width, frame.size.height))
    @buffer_image = UIImage.new
    @paths.each_with_index do |path, index|
      @path_colors[index].setStroke
      path.stroke
    end
    @buffer_image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    setNeedsDisplay
    @drawing.needs_to_render = false
  end

  def init
    super
    @brush_size = 15.0
    @brush_color = UIColor.blueColor
    @needs_to_redraw = false
    @has_input = false
    @paths ||= []
    @path_colors ||= []
    @buffer_image = UIImage.new
    @cache_brush_size = @brush_size
    self
  end

  # Touches

  def touchesBegan(touches, withEvent:event)
    touch = touches.anyObject
    @previous_point1 = touch.previousLocationInView(self)
    @previous_point2 = touch.previousLocationInView(self)
    @current_point = touch.locationInView(self)
  end

  def touchesMoved(touches, withEvent:event)
    touch = touches.anyObject
    previous = touch.previousLocationInView(self)
    current = touch.locationInView(self)

    # check for a minimal distance to avoid silly data
    dist = (sqr(current.x - @previous_point2.x) + sqr(current.y - @previous_point2.y))
    if dist > 1
      @cache_brush_size = (((1 - (dist / sqr(300))) * @brush_size) + @cache_brush_size) / 2
      @previous_point2 = @previous_point1
      @previous_point1 = previous
      @current_point = current

      # calculate mid point
      @mid1 = pointBetween(@previous_point1, andPoint:@previous_point2)
      @mid2 = pointBetween(@current_point, andPoint:@previous_point1)

      @needs_to_redraw = true
      setNeedsDisplay
    end
  end

  # Display

  def drawRect(rect)
    render_drawing if @drawing.needs_to_render
    # Avoid overdraw
    if needs_to_redraw
      # Render to buffer
      UIGraphicsBeginImageContext(frame.size)
      @buffer_image.drawInRect(CGRectMake(0, 0, frame.size.width, frame.size.height))
      @buffer_image = UIImage.new
      new_path = UIBezierPath.bezierPath
      new_path.moveToPoint(@mid1)
      new_path.addQuadCurveToPoint(@mid2, controlPoint:@previous_point1)
      new_path.setLineWidth(@cache_brush_size)
      new_path.setLineCapStyle(KCGLineCapRound)
      @brush_color.setStroke
      new_path.stroke
      # Save
      @paths.addObject(new_path)
      @path_colors.addObject(@brush_color)
      @buffer_image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      @needs_to_redraw = false
    end
    @buffer_image.drawInRect(CGRectMake(0, 0, frame.size.width, frame.size.height))
  end

  def base64png
    UIImagePNGRepresentation(@buffer_image).base64EncodedString rescue nil
  end

  def clear_drawing
    @paths = []
    @path_colors = []
    @buffer_image = UIImage.new
    @has_input = false
    setNeedsDisplay
  end

  private
  def pointBetween(point1, andPoint:point2)
    x = (point1.x + point2.x) * 0.5
    y = (point1.y + point2.y) * 0.5
    return CGPointMake(x, y)
  end
  def sqr(x); return x * x ;end
end