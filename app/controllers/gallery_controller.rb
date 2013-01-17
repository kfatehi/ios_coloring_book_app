class GalleryController < ViewController::Portrait
  include Dismissable

  outlet :collection_view

  def viewDidLoad
    p 'galleryviewdidload'
    $current_book ||= Book.restore
    @collection_view.delegate = self
    @collection_view.dataSource = $current_book
    @collection_view.reloadData
  end

  def back sender
    dismiss
  end
end