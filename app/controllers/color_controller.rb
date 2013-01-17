class ColorController < ViewController::Portrait
  include Dismissable
  
  outlet :drawing_container
  outlet :page_image
  outlet :menu_view
  outlet :current_color

  def viewDidLoad
    @current_color.layer.setBorderColor :magenta.uicolor.cgcolor
    @current_color.layer.setBorderWidth 2.0
    @current_color.backgroundColor = if $draw_view
      $draw_view.brush_color
    else
      :red.uicolor
    end
    $current_book ||= Book.restore
    $current_page ||= $current_book.restore_page
    color $current_page
    super
  end

  def back sender
    dismiss
  end

  def change_color sender
    picker = InfColorPickerController.colorPickerViewController
    picker.sourceColor = @current_color.backgroundColor
    picker.delegate = self
    picker.modalPresentationStyle = UIModalPresentationFormSheet
    @pp ||= UIPopoverController.alloc.initWithContentViewController(picker)
    @pp.setPopoverContentSize(picker.view.frame.size)
    return if @pp.isPopoverVisible
    @pp.presentPopoverFromRect(sender.frame, inView:view, permittedArrowDirections:UIPopoverArrowDirectionUp, animated:true)
  end

  def colorPickerControllerDidChangeColor picker
    @current_color.backgroundColor = picker.resultColor
    $draw_view.brush_color = picker.resultColor if $draw_view
  end

  def color page
    @page_image.image = page.image
    $draw_view = DrawView.build(page)
    $draw_view.brush_color = @current_color.backgroundColor
    @drawing_container.addSubview $draw_view
  end

  def viewWillDisappear animated
    $current_page.save_drawing
  end
end