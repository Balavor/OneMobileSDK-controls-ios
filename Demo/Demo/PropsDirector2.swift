//
//  PropsDirector2.swift
//  Demo
//
//  Created by Andrey Doroshko on 1/30/18.
//  Copyright © 2018 One by AOL : Publishers. All rights reserved.
//

import Foundation
import UIKit
import PlayerControls

public struct PropsSet {
    //var props: [DefaultControlsViewController.Props]
    
    func seeker() -> Props {
        return Props.player(Props.Player(
            playlist: Props.Playlist(
                next: .nop,
                prev: .nop),
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
                pictureInPictureControl: .unsupported,
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
                sideBarViewHidden: false,
                thumbnail: nil,
                title: ""))))
    }
    
    func emptyBottom() -> Props {
        return Props.player(Props.Player(
            playlist: Props.Playlist(
                next: .nop,
                prev: .nop),
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
                pictureInPictureControl: .unsupported,
                playbackAction: .play(.nop),
                seekbar: nil,
                settings: .hidden,
                sideBarViewHidden: true,
                thumbnail: nil,
                title: ""))))
    }
    func bottoItems() -> Props {
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
                seekbar: nil,
                settings: .enabled(.nop),
                sideBarViewHidden: false,
                thumbnail: nil,
                title: "Title"))))
    }
    func bottomFiled() -> Props {
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
                sideBarViewHidden: true,
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
}

public class PropsDirector2 {
    let viewController: DefaultControlsViewController
    let propsSet = PropsSet()
    
    init(viewController: DefaultControlsViewController) {
        self.viewController = viewController
    }
    
   private func emptySeekerBISeekerBIEmpty() {
        self.viewController.props = self.propsSet.emptyBottom()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.viewController.props = self.propsSet.seeker()
            self.viewController.sidebarProps = self.propsSet.sideProps()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.viewController.props = self.propsSet.bottomFiled()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
            self.viewController.props = self.propsSet.bottoItems()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.viewController.props = self.propsSet.emptyBottom()
        })
    }
    
   private func emptyBISeekerBIS() {
        self.viewController.props = self.propsSet.emptyBottom()
        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
            self.viewController.props = self.propsSet.bottoItems()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
            self.viewController.props = self.propsSet.bottomFiled()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
            self.viewController.props = self.propsSet.seeker()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: {
            self.viewController.props = self.propsSet.emptyBottom()
        })
    }
    
   private func emptyBIS() {
        self.viewController.props = self.propsSet.emptyBottom()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
            self.viewController.props = self.propsSet.bottomFiled()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: {
            self.viewController.props = self.propsSet.emptyBottom()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
            self.viewController.props = self.propsSet.seeker()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute: {
            self.viewController.props = self.propsSet.bottoItems()
        })
    }
    
    public func go() {
            self.emptySeekerBISeekerBIEmpty()
            self.emptyBISeekerBIS()
            self.emptyBIS()
    }
}
