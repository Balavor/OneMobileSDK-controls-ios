//  Copyright © 2017 Oath. All rights reserved.

import Foundation

final class AnimationDelegate: NSObject, CAAnimationDelegate {
    let didStop: ((CAAnimation, Bool) -> ())?
    let didStart: ((CAAnimation) ->())?
    
    init(didStart: ((CAAnimation) ->())? = nil, didStop: ((CAAnimation, Bool) -> ())? = nil) {
        self.didStop = didStop
        self.didStart = didStart
    }
        
    func animationDidStart(_ anim: CAAnimation) {
        self.didStart?(anim)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.didStop?(anim, flag)
    }
}
