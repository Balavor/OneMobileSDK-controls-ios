// Copyright © 2017 Oath. All rights reserved.

import SnappyShrimp
@testable import PlayerControls

class CaseWithSubtitlesAndCamera: SnapshotTest {
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        controller.view.backgroundColor = .red
        controller.view.tintColor = .blue
        controller.animationsAllowed = false
        
        controller.props = DefaultControlsViewController.Props.player(
            DefaultControlsViewController.Props.Player { player in
                player.playlist = DefaultControlsViewController.Props.Playlist()
                player.playlist?.prev = .nop
                player.item = DefaultControlsViewController.Props.Item.playable(
                    ContentControlsViewController.Props.Controls { controls in
                        
                        controls.title = "Some title very very very very very very very very very long"
                        
                        controls.seekbar = .init()
                        controls.seekbar?.duration = 36543
                        controls.seekbar?.currentTime = 0
                        controls.seekbar?.progress = 0
                        controls.seekbar?.buffered = 0
                        controls.seekbar?.seeker.state.stop = .nop
                        
                        controls.live.isHidden = true
                        controls.playbackAction = .play(.nop)
                        
                        controls.camera = DefaultControlsViewController.Props.Camera()
                        controls.camera?.angles.horizontal = 1.57
                        controls.camera?.angles.vertical = 1.57
                        
                        controls.settings = .enabled(.nop)
                        controls.pictureInPictureControl = .unsupported
                        controls.airplay = .hidden
                        
                        controls.legible = .external(external: .available(state: .active(text: "Let me tell you some very very very very very exiting story.")), control: DefaultControlsViewController.Props.MediaGroupControl())
                })
                
        })
        return controller
    }
    
    func test() {
        if #available(iOS 11.0, *) {
            verify(controller, for: Device.iPhoneX.portrait)
            verify(controller, for: Device.iPhoneX.landscapeLeft)
            
            verify(controller, for: Device.iPhone8.portrait)
            verify(controller, for: Device.iPhone8.landscape)
            
            verify(controller, for: Device.iPhone8Plus.landscape)
        }
        verify(controller, for: Device.iPhoneSE.portrait)
        verify(controller, for: Device.iPhoneSE.landscape)
        if #available(iOS 10.0, *) {
            verify(controller, for: Device.iPadPro9.portrait.oneThird)
            verify(controller, for: Device.iPadPro9.landscape.oneThird)
            
            verify(controller, for: Device.iPadPro10.portrait.oneThird)
        }
        verify(controller, for: Device.iPadPro12.portrait.oneThird)
        verify(controller, for: Device.iPadPro12.landscape.oneThird)
    }
}
