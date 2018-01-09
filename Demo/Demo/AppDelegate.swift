//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import PlayerControls

typealias Props = ContentControlsViewController.Props
func baseProps() -> Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: .nop,
            prev: .nop),
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
            sideBarViewHidden: false,
            thumbnail: nil,
            title: "Long titel"))))
}

func sideProps() -> [SideBarView.ButtonProps]{
    
    let shareIcons = SideBarView.ButtonProps.Icons(
        normal: UIImage(named: "icon-share", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
        selected: nil,
        highlighted: UIImage(named: "icon-share-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
    
    let share = SideBarView.ButtonProps(
        isEnabled: true,
        isSelected: false,
        icons: shareIcons,
        handler: .nop)
    
    let addIcon = SideBarView.ButtonProps.Icons(
        normal: UIImage(named: "icon-add", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
        selected: nil,
        highlighted: UIImage(named: "icon-add-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
    
    let add = SideBarView.ButtonProps(
        isEnabled: true,
        isSelected: false,
        icons: addIcon,
        handler: .nop)
    
    let favoriteIcon = SideBarView.ButtonProps.Icons(
        normal: UIImage(named: "icon-fav", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
        selected: nil,
        highlighted: UIImage(named: "icon-fav-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
    
    let favorite = SideBarView.ButtonProps(
        isEnabled: true,
        isSelected: false,
        icons: favoriteIcon,
        handler: .nop)
    
    let laterIcon = SideBarView.ButtonProps.Icons(
        normal: UIImage(named: "icon-later", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
        selected: nil,
        highlighted: UIImage(named: "icon-later-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
    
    let later = SideBarView.ButtonProps(
        isEnabled: true,
        isSelected: false,
        icons: laterIcon,
        handler: .nop)
    
    return [later, favorite, share, add]
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let vc = DefaultControlsViewController()
        vc.view.backgroundColor = .red
        vc.view.tintColor = .blue
        vc.props = baseProps()
        vc.sidebarProps = sideProps()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}

//for props animation tests

func otherProps() -> Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: nil,
            prev: .nop),
        item: .playable(Props.Controls(
            airplay: .active,
            audible: Props.MediaGroupControl(options: []),
            camera: Props.Camera(
                angles: Props.Angles(
                    horizontal: 1.57,
                    vertical: 1.57),
                moveTo: .nop),
            error: nil,
            legible: .external(
                external: .available(state: .active(text: "Something short")),
                control: Props.MediaGroupControl(options: [Props.Option(
                    name: "Option1",
                    selected: true,
                    select: .nop)])),
            live: Props.Live(
                isHidden: false,
                dotColor: .blue),
            loading: false,
            pictureInPictureControl: .possible(.nop),
            playbackAction: .replay(.nop),
            seekbar: Props.Seekbar(
                duration: 3600,
                currentTime: 0,
                progress: 0,
                buffered: 0.5,
                seeker: Props.Seeker(
                    seekTo: .nop,
                    state: Props.State(
                        start: .nop,
                        update: .nop,
                        stop: .nop))),
            settings: .hidden,
            sideBarViewHidden: true,
            thumbnail: nil,
            title: "Very very very very very long title"))))
}
func noBottomProps() -> Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: .nop,
            prev: .nop),
        item: .playable(Props.Controls(
            airplay: .hidden,
            audible: Props.MediaGroupControl(options: []),
            camera: Props.Camera(
                angles: Props.Angles(
                    horizontal: 3.14,
                    vertical: 3.14),
                moveTo: .nop),
            error: nil,
            legible: .external(
                external: .available(state: .active(text: "Something short")),
                control: Props.MediaGroupControl(options: [Props.Option(
                    name: "Option1",
                    selected: true,
                    select: .nop)])),
            live: Props.Live(
                isHidden: true,
                dotColor: nil),
            loading: true,
            pictureInPictureControl: .unsupported,
            playbackAction: .pause(.nop),
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
            sideBarViewHidden: false,
            thumbnail: nil,
            title: ""))))
}

