// Copyright © 2018 Oath. All rights reserved.

import Foundation

extension DefaultControlsViewController {

struct BottomItemsState {
    let seekerViewHidden: Bool
    let airplayButtonHidden: Bool
    let pipButtonHidden: Bool
    let settingsButtonHidden: Bool
    let videoTitleLabelHidden: Bool
    
    var areAllButtonsHidden: Bool {
        return airplayButtonHidden && pipButtonHidden && settingsButtonHidden && videoTitleLabelHidden
    }
    var areAllButtonsVisible: Bool {
        return !airplayButtonHidden && !pipButtonHidden && !settingsButtonHidden && !videoTitleLabelHidden
    }
}

struct BottomItemsAnimationTypes {
    
    let seekerAnimationType: AnimationType
    let airplayAnimationType: AnimationType
    let pipAnimationType: AnimationType
    let settingsAnimationType: AnimationType
    let videoTitleLabelAnimationType: AnimationType
}

func determineBottomAnimationType(from oldState: BottomItemsState, to newState: BottomItemsState) -> BottomItemsAnimationTypes {
    
    let isSeekerChanged = oldState.seekerViewHidden != newState.seekerViewHidden
    let isVideoTitleChanged = oldState.videoTitleLabelHidden != newState.videoTitleLabelHidden
    
    let isSettingsChanged = oldState.settingsButtonHidden != newState.settingsButtonHidden
    let isAirplayChanged = oldState.airplayButtonHidden != newState.airplayButtonHidden
    let isPipChanged = oldState.pipButtonHidden != newState.pipButtonHidden
    
    let areAllButtonsChanged = isSettingsChanged &&  isAirplayChanged && isPipChanged
    
    func getSeekerAnimationType() -> AnimationType {
        guard isSeekerChanged else { return .none }
        if newState.seekerViewHidden {
            guard newState.videoTitleLabelHidden && newState.areAllButtonsHidden else { return .fade }
        } else {
            guard oldState.videoTitleLabelHidden && oldState.areAllButtonsHidden else { return .fade }
        }
        return .slide
    }
    func getVideoTitleAnimationType() -> AnimationType {
        guard isVideoTitleChanged else { return .none }
        return .slide
    }
    
    func getSettitngsAnimatinoType() -> AnimationType {
        
        if areAllButtonsChanged {
            if newState.areAllButtonsHidden || oldState.areAllButtonsVisible { return .slide  }
        }
        
        if isSettingsChanged {
            let airplayReplacesSettings = isAirplayChanged && (newState.airplayButtonHidden != newState.settingsButtonHidden)
            let pipReplacesSettings = isPipChanged && (newState.pipButtonHidden != newState.airplayButtonHidden)
            
            if (pipReplacesSettings || airplayReplacesSettings) && !newState.settingsButtonHidden {
                return .fade
            } else {
                return .slide
            }
        } else {
            if isAirplayChanged { return .move }
            if isPipChanged { return .move }
        }
        return .none
    }
    
    func getAirplayAnimationType() -> AnimationType {
        
        if areAllButtonsChanged {
            if newState.areAllButtonsHidden || oldState.areAllButtonsVisible { return .slide  }
        }
        
        if isAirplayChanged {
            let pipReplacesAirplay = isPipChanged && (newState.pipButtonHidden != newState.airplayButtonHidden)
            let settingsReplacesAirplay = isSettingsChanged && (newState.settingsButtonHidden != newState.airplayButtonHidden)
            
            if (pipReplacesAirplay || settingsReplacesAirplay) && !newState.airplayButtonHidden
            {
                return .fade
            } else {
                return .slide
            }
        } else {
            guard !isPipChanged else { return .move }
        }
        return .none
    }
    
    func getPiPAnimationType() -> AnimationType {
        if areAllButtonsChanged {
            if newState.areAllButtonsHidden || oldState.areAllButtonsVisible { return .slide  }
        }
        
        if isPipChanged {
            let settingsReplacesPip = isSettingsChanged && (newState.settingsButtonHidden != newState.pipButtonHidden)
            let airplayReplacesPip = isAirplayChanged && (newState.airplayButtonHidden != newState.pipButtonHidden)
            
            if (settingsReplacesPip || airplayReplacesPip) && !newState.pipButtonHidden
            {
                return .fade
            } else {
                return .slide
            }
        }
        return .none
    }
    
    return BottomItemsAnimationTypes(
        seekerAnimationType: getSeekerAnimationType(),
        airplayAnimationType: getAirplayAnimationType(),
        pipAnimationType: getPiPAnimationType(),
        settingsAnimationType: getSettitngsAnimatinoType(),
        videoTitleLabelAnimationType: getVideoTitleAnimationType()
    )
}
}

extension DefaultControlsViewController.BottomItemsAnimationTypes: Equatable {
    static func ==(lhs: DefaultControlsViewController.BottomItemsAnimationTypes, rhs: DefaultControlsViewController.BottomItemsAnimationTypes) -> Bool {
        return lhs.seekerAnimationType == rhs.seekerAnimationType
            && lhs.videoTitleLabelAnimationType == rhs.videoTitleLabelAnimationType
            && lhs.airplayAnimationType == rhs.airplayAnimationType
            && lhs.pipAnimationType == rhs.pipAnimationType
            && lhs.settingsAnimationType == rhs.settingsAnimationType
    }
}
