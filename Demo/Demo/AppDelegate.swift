//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import PlayerControls

typealias Props = ContentControlsViewController.Props

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let vc = DefaultControlsViewController()
        vc.view.backgroundColor = .red
        vc.view.tintColor = .blue
        let director = PropsDirector2(viewController: vc)
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 15, repeats: true, block: { _ in
                director.go()
            })
        } else {
            // Fallback on earlier versions
        }
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}

//func propsAllButtonsVisible() -> [ButtonsProps] {
//    let props: [ButtonsProps] = [
//        ButtonsProps(settingsState: .hidden, airplayState: .enabled, pipState: .possible(.nop)),
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop)),
//
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .possible(.nop)),
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop)),
//
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .unsupported),
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop)),
//
//        ButtonsProps(settingsState: .hidden, airplayState: .hidden, pipState: .possible(.nop)),
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop)),
//
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .unsupported),
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop)),
//
//        ButtonsProps(settingsState: .hidden, airplayState: .enabled, pipState: .unsupported),
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop)),
//
//        ButtonsProps(settingsState: .hidden, airplayState: .hidden, pipState: .unsupported),
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop))
//    ]
//    return props
//}

//func propsTwoButtonsVisible() -> [ButtonsProps] {
//    let props: [ButtonsProps] = [
//        ButtonsProps(settingsState: .hidden, airplayState: .enabled, pipState: .possible(.nop)),
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .possible(.nop)),
//        ButtonsProps(settingsState: .hidden, airplayState: .enabled, pipState: .possible(.nop)),
//
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .unsupported),
//        ButtonsProps(settingsState: .hidden, airplayState: .enabled, pipState: .possible(.nop)),
//
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .unsupported),
//        ButtonsProps(settingsState: .hidden, airplayState: .enabled, pipState: .possible(.nop)),
//
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .unsupported),
//        ButtonsProps(settingsState: .hidden, airplayState: .enabled, pipState: .possible(.nop)),
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .unsupported),
//
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .unsupported),
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .possible(.nop)),
//        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .unsupported)
//    ]
//    return props
//}

func propsCombination2() -> [ButtonsProps] {
    let props: [ButtonsProps] = [
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop), seekerState: nil),
        ButtonsProps(settingsState: .hidden, airplayState: .enabled, pipState: .possible(.nop), seekerState: nil),
        ButtonsProps(settingsState: .hidden, airplayState: .hidden, pipState: .possible(.nop), seekerState: nil),
        ButtonsProps(settingsState: .hidden, airplayState: .hidden, pipState: .unsupported, seekerState: nil),
        ButtonsProps(settingsState: .hidden, airplayState: .enabled, pipState: .unsupported, seekerState: nil),
        ButtonsProps(settingsState: .hidden, airplayState: .enabled, pipState: .possible(.nop), seekerState: nil),
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop), seekerState: nil),
        
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .unsupported, seekerState: nil),
        ButtonsProps(settingsState: .hidden, airplayState: .hidden, pipState: .possible(.nop), seekerState: nil),
        ButtonsProps(settingsState: .hidden, airplayState: .enabled, pipState: .unsupported, seekerState: nil),
        
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop), seekerState: nil),
        ButtonsProps(settingsState: .hidden, airplayState: .hidden, pipState: .unsupported, seekerState: nil),
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop), seekerState: nil),
    ]
    return props
}

func propsWithPipOnly() -> [ButtonsProps] {
    let props: [ButtonsProps] = [
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled,
                     pipState: .possible(.nop),
                     seekerState: Props.Seekbar(
                        duration: 3600,
                        currentTime: 1800,
                        progress: 0.5,
                        buffered: 0.7,
                        seeker: Props.Seeker(
                            seekTo: .nop,
                            state: Props.State(
                                start: .nop,
                                update: .nop,
                                stop: .nop)))),
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .unsupported, seekerState: nil),
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop), seekerState: nil),
        //ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .impossible, seekerState: nil),
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop), seekerState: nil),
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .unsupported, seekerState: nil),
        ButtonsProps(settingsState: .hidden, airplayState: .hidden, pipState: .unsupported, seekerState: nil),
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .unsupported, seekerState: nil),
        ButtonsProps(settingsState: .hidden, airplayState: .hidden, pipState: .possible(.nop), seekerState: nil),
        
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .unsupported, seekerState: nil),
        ButtonsProps(settingsState: .hidden, airplayState: .enabled, pipState: .unsupported, seekerState: nil),
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .unsupported, seekerState: nil)
    ]
    return props
}

func propsAirPlayOnly() -> [ButtonsProps] {
    let props: [ButtonsProps] = [
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop), seekerState: nil),
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .possible(.nop), seekerState: nil),
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .unsupported, seekerState: nil),
        ButtonsProps(settingsState: .hidden, airplayState: .hidden, pipState: .unsupported, seekerState: nil),
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .hidden, pipState: .unsupported, seekerState: nil),
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .unsupported, seekerState: nil),
        ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop), seekerState: nil),
    ]
    return props
}

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
