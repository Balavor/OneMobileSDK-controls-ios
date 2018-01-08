// Copyright © 2018 Oath. All rights reserved.

import UIKit

protocol Animators {
    var isAvailable: Bool { get set }
    var isHidden: Bool { get set }
    
    func animate(for visibility: Bool)
}

class AnimatorGroup {
    var animators: [Animators]!
    
    var props: ContentControlsViewController.Props!
    
    func performAnimation(if controlsVisible: Bool) {
        guard !animators.isEmpty else { return }
        for animator in animators {
            animator.animate(for: controlsVisible)
        }
    }
}

