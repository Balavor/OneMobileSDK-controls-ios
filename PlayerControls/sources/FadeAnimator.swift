// Copyright © 2017 Oath. All rights reserved.

import UIKit

class FadeAnimator: NSObject, Animators {
    
    @IBOutlet var fadingVeiw: UIView!
    
    var isHidden: Bool = false
    
    var isAvailable: Bool = true
    
    func animate(for visibility: Bool) {
        guard fadingVeiw != nil else { return }
        if isAvailable {
            fadingVeiw.alpha = visibility ? 1 : 0
            isHidden = visibility
        }
    }
}

