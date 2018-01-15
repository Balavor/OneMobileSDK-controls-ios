// Copyright © 2018 Oath. All rights reserved.

import UIKit

class Animator: NSObject {
    
    @IBOutlet var activeConstraint: [NSLayoutConstraint]!
    @IBOutlet var inactiveConstraint: [NSLayoutConstraint]!
    @IBOutlet var animatedView: UIView!
    
    var maxAlpha: CGFloat = 1
    var isHidden: Bool = false {
        didSet {
            if isHidden {
                animatedView.isHidden = isHidden
                UIView.animate(withDuration: 0.4, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
                    self.animatedView.superview?.layoutIfNeeded()
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.4, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
                    self.animatedView.superview?.layoutIfNeeded()
                }) { _ in
                    self.animatedView.isHidden = self.isHidden
                }
            }
        }
    }
    
    func slide(if hidden: Bool) {
        inactiveConstraint.forEach { $0.isActive = hidden }
        activeConstraint.forEach { $0.isActive = !hidden }
    }
    func fade(if hidden: Bool) {
        animatedView.alpha = hidden ? 0 : maxAlpha
    }
}

