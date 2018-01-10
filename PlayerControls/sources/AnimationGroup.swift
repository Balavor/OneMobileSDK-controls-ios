// Copyright © 2018 Oath. All rights reserved.

import UIKit

protocol Animators {
    var isHidden: Bool { get set }
    
    func animate(for visibility: Bool)
}

class AnimatorGroup {
    var animators: [Animators]!
    
    func performAnimation(forState state: Bool) {
        guard !animators.isEmpty else { return }
        for animator in animators {
            animator.animate(for: state)
        }
    }
}

