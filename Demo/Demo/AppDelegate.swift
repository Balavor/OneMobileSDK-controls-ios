//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import PlayerControls

typealias Props = ContentControlsViewController.Props
func props() -> Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: nil,
            prev: nil),
        item: .playable(Props.Controls(
            airplay: .enabled,
            audible: Props.MediaGroupControl(options: []),
            camera: Props.Camera(
                angles: Props.Angles(
                    horizontal: 0.0,
                    vertical: 0.0),
                moveTo: .nop),
            error: nil,
            legible: .external(
                external: .available(state: .active(text: "Somthing short")),
                control: Props.MediaGroupControl(options: [Props.Option(
                    name: "Option1",
                    selected: true,
                    select: .nop)])),
            live: Props.Live(
                isHidden: false,
                dotColor: nil),
            loading: false,
            pictureInPictureControl: .possible(.nop),
            playbackAction: .play(.nop),
            seekbar: Props.Seekbar(
                duration: 3600,
                currentTime: 1800,
                progress: 0.5,
                buffered: 0.7,
                seeker: Props.Seeker(
                    seekTo: .nop,
                    state: Props.State(
                        start: .nop,
                        update: .nop,
                        stop: .nop))),
            settings: .enabled(.nop),
            sideBarViewHidden: true,
            thumbnail: nil,
            title: "Long titel"))))
}

func props2() -> Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: nil,
            prev: nil),
        item: .playable(Props.Controls(
            airplay: .enabled,
            audible: Props.MediaGroupControl(options: []),
            camera: Props.Camera(
                angles: Props.Angles(
                    horizontal: 0.0,
                    vertical: 0.0),
                moveTo: .nop),
            error: nil,
            legible: .external(
                external: .available(state: .active(text: "Somthing short")),
                control: Props.MediaGroupControl(options: [Props.Option(
                    name: "Option1",
                    selected: true,
                    select: .nop)])),
            live: Props.Live(
                isHidden: false,
                dotColor: nil),
            loading: false,
            pictureInPictureControl: .possible(.nop),
            playbackAction: .play(.nop),
            seekbar: Props.Seekbar(
                duration: 3600,
                currentTime: 1800,
                progress: 0.5,
                buffered: 0.7,
                seeker: Props.Seeker(
                    seekTo: .nop,
                    state: Props.State(
                        start: .nop,
                        update: .nop,
                        stop: .nop))),
            settings: .hidden,
            sideBarViewHidden: true,
            thumbnail: nil,
            title: "Long titel"))))
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let vc = DefaultControlsViewController()
        vc.view.backgroundColor = .green
        vc.view.tintColor = .blue
        vc.props = props()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            vc.props = props2()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            vc.props = props()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            vc.props = props2()
        }
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}



