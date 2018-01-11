// Copyright © 2018 Oath. All rights reserved.
import Foundation

extension DefaultControlsViewController {
    struct BottomItemsState {
        let seekerIsHidden: Bool
        let durationIsHidden: Bool
        
        let titleIsHidden: Bool
        let airplayIsHidden: Bool
        let pipIsHidden: Bool
        let settingsIsHidden: Bool
    
        func animate(into props: DefaultControlsViewController.UIProps) {
            if seekerIsHidden == !props.seekerViewHidden
                && durationIsHidden == !props.durationTextHidden
                && titleIsHidden == !props.videoTitleLabelHidden
                && airplayIsHidden == !props.airplayButtonHidden
                && pipIsHidden == !props.pipButtonHidden
                && settingsIsHidden == !props.settingsButtonHidden {
                
            }
        }
   }
}
