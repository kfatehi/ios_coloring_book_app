class GalleryController < ViewController::Portrait
  outlet :collection_view

  def viewDidLoad
    p 'galleryviewdidload'
    $current_book ||= Book.restore
    @collection_view.delegate = self
    @collection_view.dataSource = $current_book
    @collection_view.reloadData
  end
end