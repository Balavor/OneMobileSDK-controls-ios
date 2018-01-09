// Copyright © 2018 Oath. All rights reserved.

import UIKit

class SlideAnimator: NSObject, Animators {
    
    @IBOutlet var activeConstraint: [NSLayoutConstraint]!
    @IBOutlet var inactiveConstraint: [NSLayoutConstraint]!
    
    var isAvailable: Bool = true
    var isHidden: Bool = false
    
    func animate(for visibility: Bool) {
        for constraint in inactiveConstraint {
            constraint.isActive = !visibility
        }
        for constraint in activeConstraint {
            constraint.isActive = visibility
        }
    }
}

