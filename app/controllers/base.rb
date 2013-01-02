module ViewController
  class Base < UIViewController
    extend IB
    
    def masks
      [UIInterfaceOrientationMaskAll]
    end
    
    def orientations
      [UIInterfaceOrientationPortrait, UIInterfaceOrientationPortraitUpsideDown,
       UIInterfaceOrientationLandscapeLeft, UIInterfaceOrientationLandscapeRight]
    end
    
    def shouldAutorotateToInterfaceOrientation(o)
      orientations.include?(o)
    end

    def supportedInterfaceOrientations
      masks.inject {|i,n| i | n}
    end

    def shouldAutorotate
      true
    end

    def textFieldShouldReturn(textfield)
      textfield.resignFirstResponder
    end
  end

  class Portrait < Base
    def orientations
      [UIInterfaceOrientationPortrait, UIInterfaceOrientationPortraitUpsideDown]
    end
    def masks
      [UIInterfaceOrientationMaskPortrait, UIInterfaceOrientationMaskPortraitUpsideDown]
    end
  end

  class Landscape < Base
    def orientations
      [UIInterfaceOrientationLandscapeRight, UIInterfaceOrientationLandscapeLeft]
    end
    def masks
      [UIInterfaceOrientationMaskLandscapeRight, UIInterfaceOrientationMaskLandscapeLeft]
    end
  end
end
