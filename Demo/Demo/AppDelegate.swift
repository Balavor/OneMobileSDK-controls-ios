//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import PlayerControls

typealias Props = ContentControlsViewController.Props
func pipOnly() -> Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: nil,
            prev: nil),
        item: .playable(Props.Controls(
            airplay: .hidden,
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

func pipSettings() -> Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: nil,
            prev: nil),
        item: .playable(Props.Controls(
            airplay: .hidden,
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

func pipAirPlaySettings() -> Props {
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

func pipAirPlay() -> Props {
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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let vc = DefaultControlsViewController()
        vc.view.backgroundColor = .green
        vc.view.tintColor = .blue
        vc.props = pipAirPlaySettings()

        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
            vc.props = pipSettings()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
            vc.props = pipOnly()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 18, execute: {
            vc.props = pipSettings()        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 24, execute: {
            vc.props = pipAirPlaySettings()
        })



        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}



