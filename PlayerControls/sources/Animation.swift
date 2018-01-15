//
//  Animation.swift
//  PlayerControls
//
//  Created by Andrey Doroshko on 1/15/18.
//  Copyright © 2018 One by AOL : Publishers. All rights reserved.
//

import Foundation

protocol HiddenAnimator: class {
    var isHidden: Bool { get set }
}

class Animator: NSObject, HiddenAnimator {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet var activeConstraints: [NSLayoutConstraint]!
    @IBOutlet var inavtiveConstraints: [NSLayoutConstraint]!
    
    var animationType: AnimationType?
    var isHidden: Bool = false {
        didSet {
            switch animationType {
            case .fade?:
                fade()
            case .slide?:
                slide()
            case nil:
                break
            }
        }
    }
    
    enum AnimationType {
        case fade, slide
    }
    
    func slide() {
        self.activeConstraints.forEach { $0.isActive = !self.isHidden }
        self.inavtiveConstraints.forEach { $0.isActive = self.isHidden }
        
        view.setNeedsUpdateConstraints()
        UIView.animate(
            withDuration: 0.3,
            animations: self.view.superview!.layoutIfNeeded
        )
        
        self.view.isHidden = self.isHidden
        
        self.activeConstraints.forEach { $0.isActive = !self.isHidden }
        self.inavtiveConstraints.forEach { $0.isActive = self.isHidden }
    }
    
    func fade() {
        
        view.layer.opacity = 0
        
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: { self.view.layer.opacity = 1 },
                       completion: nil)
        
        view.isHidden = self.isHidden
        
    }
}

