// Copyright © 2018 Oath. All rights reserved.

import UIKit

class FadeAnimator: NSObject, Animators {
    
    @IBOutlet var fadingView: UIView!
    var maxAlpha: CGFloat = 1
    
    var isHidden: Bool = false
    
    func animate(for visibility: Bool) {
        if fadingView.alpha == 0 {
            fadingView.isHidden = visibility && isHidden
            fadingView.alpha = !visibility && !isHidden ? maxAlpha : 0
        } else {
            fadingView.alpha = !visibility && !isHidden ? maxAlpha : 0
            fadingView.isHidden = visibility && isHidden
        }
    }
}

