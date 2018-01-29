//
//  Constraint.swift
//  PlayerControls
//
//  Created by Andrey Doroshko on 1/29/18.
//  Copyright © 2018 One by AOL : Publishers. All rights reserved.
//

import Foundation

class AnimationsConstraint: NSObject {
    @IBOutlet private var visibleConstraint: NSLayoutConstraint!
    @IBOutlet private var inVisibleConstraint: NSLayoutConstraint!
    
    public func toggleToInVisible(){
        visibleConstraint.isActive = false
        inVisibleConstraint.isActive = true
    }
    
    public func toggleToVisible(){
        inVisibleConstraint.isActive = false
        visibleConstraint.isActive = true
    }
    
}
