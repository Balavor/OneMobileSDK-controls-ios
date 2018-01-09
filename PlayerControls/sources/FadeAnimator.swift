// Copyright © 2018 Oath. All rights reserved.

import UIKit

class FadeAnimator: NSObject, Animators {
    
    @IBOutlet var fadingView: UIView!
    
    var isHidden: Bool = false
    var maxAlpha: CGFloat = 1
    var isAvailable: Bool = true
    
    func animate(for visibility: Bool) {
        guard fadingViews != nil else { return }
        fadingView.alpha = isAvailable && visibility ? maxAlpha : 0
    }
}

