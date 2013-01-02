class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    $debug_path = File.join(App.documents_path, 'testfile')
    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
    switch_to_vc load_vc("WelcomeController")
  end

  def applicationWillResignActive(application)
    $current_page.save_drawing if $current_page
  end

  private
  def load_vc(identifier)
    name = "#{Device.iphone? ? 'iPhone' : 'iPad'}Storyboard"
    storyboard = UIStoryboard.storyboardWithName(name, bundle: NSBundle.mainBundle)
    vc = storyboard.instantiateViewControllerWithIdentifier(identifier)
  end

  def switch_to_vc(vc)
    unless @window.rootViewController == vc
      @window.rootViewController = vc
      @window.rootViewController.wantsFullScreenLayout = true
      @window.makeKeyAndVisible
    end
  end
end
