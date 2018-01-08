// Copyright © 2018 Oath. All rights reserved.

import UIKit

class FadeAnimator: NSObject, Animators {
    
    @IBOutlet var fadingView: UIView!
    @IBOutlet var fadingViews: [UIView]!
    
    var isHidden: Bool = false
    var maxAlpha: CGFloat = 1
    var isAvailable: Bool = true
    
    func animate(for visibility: Bool) {
        guard fadingViews == nil else {
            for view in fadingViews {
                view.alpha = isAvailable && visibility ?  maxAlpha : 0
            }
            return
        }
        fadingView.alpha = isAvailable && visibility ? maxAlpha : 0
    }
}

