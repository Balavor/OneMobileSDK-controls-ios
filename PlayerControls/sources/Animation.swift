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
    
    var animationType: AnimationType? = .fade
    var isHidden: Bool = false {
        didSet {
            guard oldValue != isHidden else { return }
            fade()
        }
    }
    
    enum AnimationType {
        case fade, slide
    }
    
    func slide() {
        print("in slide")
        self.activeConstraints.forEach { $0.isActive = !self.isHidden }
        self.inavtiveConstraints.forEach { $0.isActive = self.isHidden }
        
        view.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.curveEaseIn],
                       animations: self.view.superview!.layoutIfNeeded,
                       completion: { (finished: Bool) in
                        self.view.isHidden = self.isHidden
                        self.inavtiveConstraints.forEach { $0.isActive = self.isHidden }
                        self.activeConstraints.forEach { $0.isActive = !self.isHidden }
                        //self.view.isHidden = self.isHidden
            }
        )
    }
    
    func fade() {
        
        view.alpha = 0
        
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: { self.view.alpha = 1 },
                       completion: nil)
        
        view.isHidden = self.isHidden
        
    }
}

