//
//  Animation.swift
//  PlayerControls
//
//  Created by Andrey Doroshko on 1/15/18.
//  Copyright © 2018 One by AOL : Publishers. All rights reserved.
//

import Foundation

class Constraints: NSObject {
    
    @IBOutlet private var activeConstraints: [NSLayoutConstraint]!
    @IBOutlet private var inavtiveConstraints: [NSLayoutConstraint]!
    
    func toggleToMakeVisible() {
        self.inavtiveConstraints.forEach { $0.isActive = false }
        self.activeConstraints.forEach { $0.isActive = true }
    }
    
    func toggleToMakeInVisible() {
        self.activeConstraints.forEach { $0.isActive = false }
        self.inavtiveConstraints.forEach { $0.isActive = true }   
    }
}

