//
//  AnimationForBottomItems.swift
//  PlayerControls
//
//  Created by Andrey Doroshko on 1/21/18.
//  Copyright © 2018 One by AOL : Publishers. All rights reserved.
//

import Foundation

extension DefaultControlsViewController {
    enum AnimationType {
        case fade, slide, move, `none`
    }
    
    func performSettingsButtonAnimation(type: AnimationType, isHidden: Bool) {
        switch (type, isHidden) {
        case (.fade, true):
            print("Set in fade out")
            settingsButton.alpha = 1
            
            CATransaction.begin()
            
            CATransaction.setCompletionBlock({
                self.settingsButton.isHidden = true
            })
            
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.duration = 0.5
            
            settingsButton.layer.add(animation, forKey: "opacity")
            settingsButton.alpha = 0.1
            
            CATransaction.commit()
            
            
        case (.fade, false):
            print("Set in fade in")
            settingsButton.alpha = 0
            settingsButton.isHidden = false
            
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                CATransaction.begin()
                
                let animation = CABasicAnimation(keyPath: "opacity")
                animation.duration = 0.5
                
                self.settingsButton.layer.add(animation, forKey: "opacity")
                self.settingsButton.alpha = 1
                
                CATransaction.commit()
                
            }
            CATransaction.commit()
            
        case (.slide, true):
            print("Set in slide down")
            settingConstraints.toggleToMakeInVisible()
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.settingsButton.isHidden = true
                self.settingConstraints.toggleToMakeVisible()
            })
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.5
            
            settingsButton.layer.add(animation, forKey: "position")
            CATransaction.commit()
            
        case (.slide, false):
            print("Set in slide up")
            
            CATransaction.begin()
            airplayConstraints.toggleToMakeInVisible()
            
            CATransaction.setCompletionBlock {
                
                CATransaction.begin()
                self.settingsButton.isHidden = false
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.5
                
                self.settingsButton.layer.add(animation, forKey: "posiotion")
                self.settingConstraints.toggleToMakeVisible()
                
                CATransaction.commit()
                
            }
            CATransaction.commit()
            
        case (.move, _):
            print("Set in move")
            CATransaction.begin()
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.5
            
            settingsButton.layer.add(animation, forKey: "position")
            
            CATransaction.commit()
            
        case (.none, _):
            print("Set does nothing")
            return
        }
    }
    
    func performAirPlayButtonAnimation(type: AnimationType, isHidden: Bool) {
        switch (type, isHidden) {
        case (.fade, true):
            print("AP in fade out")
            airPlayView.alpha = 1
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.airPlayView.isHidden = true
            })
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.duration = 0.5
            
            airPlayView.layer.add(animation, forKey: "position")
            airPlayView.alpha = 0.1
            
            CATransaction.commit()
            
        case (.fade, false):
            print("AP in fade in")
            airPlayView.alpha = 0.1
            airPlayView.isHidden = false
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                CATransaction.begin()
                
                let animation = CABasicAnimation(keyPath: "opacity")
                animation.duration = 0.5
                
                self.airPlayView.layer.add(animation, forKey: "opacity")
                self.airPlayView.alpha = 1
                CATransaction.commit()
            })
            CATransaction.commit()
            
        case (.slide, true):
            print("AP in slide down")
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.airPlayView.isHidden = true
                self.airplayConstraints.toggleToMakeVisible()
            })
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.5
            
            airPlayView.layer.add(animation, forKey: "position")
            airplayConstraints.toggleToMakeInVisible()
            CATransaction.commit()
            
        case (.slide, false):
            print("AP in slide up")
            CATransaction.begin()
            airplayConstraints.toggleToMakeInVisible()
            
            CATransaction.setCompletionBlock {
                
                CATransaction.begin()
                self.airPlayView.isHidden = false
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.5
                
                self.airPlayView.layer.add(animation, forKey: "posiotion")
                self.airplayConstraints.toggleToMakeVisible()
                
                CATransaction.commit()
                
            }
            CATransaction.commit()
            
        case (.move, _):
            print("AP in move")
            CATransaction.begin()
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.5
            
            airPlayView.layer.add(animation, forKey: "position")
            
            CATransaction.commit()
            
        case (.none, _):
            print("AP does nothing")
            return
        }
    }
    
    func performPipButtonAnimation(type: AnimationType, isHidden: Bool) {
        switch (type, isHidden) {
        case (.fade, true):
            print("PiP in fade out")
            pipButton.alpha = 1
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.pipButton.isHidden = true
            })
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.duration = 0.5
            
            pipButton.layer.add(animation, forKey: "position")
            pipButton.alpha = 0.1
            
            CATransaction.commit()
            
        case (.fade, false):
            print("PiP in fade in")
            pipButton.alpha = 0.1
            pipButton.isHidden = false
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                CATransaction.begin()
                
                let animation = CABasicAnimation(keyPath: "opacity")
                animation.duration = 0.5
                
                self.pipButton.layer.add(animation, forKey: "opacity")
                self.pipButton.alpha = 1
                CATransaction.commit()
            })
            CATransaction.commit()
            
        case (.slide, true):
            print("PiP in slide down")
            pipConstraints.toggleToMakeInVisible()
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.pipButton.isHidden = true
                self.pipConstraints.toggleToMakeVisible()
            })
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.5
            
            pipButton.layer.add(animation, forKey: "position")
            CATransaction.commit()
            
        case (.slide, false):
            print("PiP in slide up")
            CATransaction.begin()
            pipConstraints.toggleToMakeInVisible()
            
            CATransaction.setCompletionBlock {
                
                CATransaction.begin()
                self.pipButton.isHidden = false
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.5
                
                self.pipButton.layer.add(animation, forKey: "posiotion")
                self.pipConstraints.toggleToMakeVisible()
                
                CATransaction.commit()
                
            }
            CATransaction.commit()
            
        case (.move, _):
            print("PiP in move")
            CATransaction.begin()
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.5
            
            pipButton.layer.add(animation, forKey: "position")
            
            CATransaction.commit()
            
        case (.none, _):
            print("PiP does nothing")
            return
        }
    }
    
    func performSeekerAnimation(type: AnimationType, isHidden: Bool) {
        switch (type, isHidden) {
        case (.fade, true):
            print("Seeker in fade out")
            seekerView.alpha = 1
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.seekerView.isHidden = true
            })
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.duration = 0.5
            
            seekerView.layer.add(animation, forKey: "position")
            seekerView.alpha = 0.1
            
            CATransaction.commit()
            
        case (.fade, false):
            print("Seeker in fade in")
            seekerView.alpha = 0.1
            seekerView.isHidden = false
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                CATransaction.begin()
                
                let animation = CABasicAnimation(keyPath: "opacity")
                animation.duration = 0.5
                
                self.seekerView.layer.add(animation, forKey: "opacity")
                self.seekerView.alpha = 1
                CATransaction.commit()
            })
            CATransaction.commit()
            
        case (.slide, true):
            print("Seeker in slide down")
            seekerConstraints.toggleToMakeInVisible()
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.seekerView.isHidden = true
                self.seekerConstraints.toggleToMakeVisible()
            })
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.5
            
            seekerView.layer.add(animation, forKey: "position")
            CATransaction.commit()
            
        case (.slide, false):
            print("Seeker in slide up")
            CATransaction.begin()
            seekerConstraints.toggleToMakeInVisible()
            
            CATransaction.setCompletionBlock {
                
                CATransaction.begin()
                self.seekerView.isHidden = false
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.5
                
                self.pipButton.layer.add(animation, forKey: "posiotion")
                self.seekerConstraints.toggleToMakeVisible()
                
                CATransaction.commit()
                
            }
            CATransaction.commit()
            
        case (.move, _):
            print("Seeker in move")
            CATransaction.begin()
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.5
            
            seekerView.layer.add(animation, forKey: "position")
            
            CATransaction.commit()
            
        case (.none, _):
            print("Seekerr does nothing")
            return
        }
    }
}
