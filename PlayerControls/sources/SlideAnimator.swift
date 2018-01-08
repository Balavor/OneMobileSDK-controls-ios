// Copyright © 2017 Oath. All rights reserved.

import UIKit

class SlideAnimator: NSObject, Animators {
    
    @IBOutlet var activeConstraint: NSLayoutConstraint!
    @IBOutlet var inactiveConstraint: NSLayoutConstraint!
    
    var isAvailable: Bool = true
    var isHidden: Bool = false
    
    func animate(for visibility: Bool) {
        inactiveConstraint.isActive = visibility
        activeConstraint.isActive = !visibility
    }
}

