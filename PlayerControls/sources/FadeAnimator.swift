// Copyright © 2018 Oath. All rights reserved.

import UIKit

class FadeAnimator: NSObject, Animators {
    
    @IBOutlet var fadingView: UIView!
    var maxAlpha: CGFloat = 1
    
    var isHidden: Bool = false
    
    func animate(for visibility: Bool) {
        fadingView.alpha = visibility ? maxAlpha : 0
    }
}

