//  Copyright © 2018 One by AOL : Publishers. All rights reserved.

import PlayerControls

let liveVideoScript: [Props] = [
    defaultVideoProps(),
    liveActionProps(),
    defaultVideoProps()
]

let noBottomItems: [Props] = [
    defaultVideoProps(),
    noBottomItemsProps(),
    defaultVideoProps()
]

let nextVideoInPlaylist: [Props] = [
    defaultVideoProps(),
    nextButtonClicked(),
    nextVideoLoaded()
]

func defaultVideoProps() -> Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: .nop,
            prev: nil),
        item: .playable(Props.Controls(
            airplay: .enabled,
            audible: Props.MediaGroupControl(options: []),
            camera: nil,
            error: nil,
            legible: .external(
                external: .none,
                control: Props.MediaGroupControl(options: [Props.Option(
                    name: "Option1",
                    selected: true,
                    select: .nop)])),
            live: Props.Live(
                isHidden: true,
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
            title: "Long title"))))
}

func liveActionProps() -> Props {
    return Props.player(Props.Player(
        playlist: nil,
        item: .playable(Props.Controls(
            airplay: .enabled,
            audible: Props.MediaGroupControl(options: []),
            camera: nil,
            error: nil,
            legible: .external(
                external: .none,
                control: Props.MediaGroupControl(options: [Props.Option(
                    name: "Option1",
                    selected: true,
                    select: .nop)])),
            live: Props.Live(
                isHidden: false,
                dotColor: .green),
            loading: false,
            pictureInPictureControl: .possible(.nop),
            playbackAction: .play(.nop),
            seekbar: nil,
            settings: .enabled(.nop),
            sideBarViewHidden: false,
            thumbnail: nil,
            title: "Long title"))))
}

func noBottomItemsProps() -> Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: .nop,
            prev: nil),
        item: .playable(Props.Controls(
            airplay: .hidden,
            audible: Props.MediaGroupControl(options: []),
            camera: nil,
            error: nil,
            legible: .external(
                external: .none,
                control: Props.MediaGroupControl(options: [Props.Option(
                    name: "Option1",
                    selected: true,
                    select: .nop)])),
            live: Props.Live(
                isHidden: true,
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

func nextButtonClicked() -> Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: nil,
            prev: .nop),
        item: .playable(Props.Controls(
            airplay: .hidden,
            audible: Props.MediaGroupControl(options: []),
            camera: nil,
            error: nil,
            legible: .external(
                external: .none,
                control: Props.MediaGroupControl(options: [Props.Option(
                    name: "Option1",
                    selected: true,
                    select: .nop)])),
            live: Props.Live(
                isHidden: true,
                dotColor: nil),
            loading: true,
            pictureInPictureControl: .unsupported,
            playbackAction: .none,
            seekbar: Props.Seekbar(
                duration: 0,
                currentTime: 0,
                progress: 0,
                buffered: 0,
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

func nextVideoLoaded() -> Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: nil,
            prev: .nop),
        item: .playable(Props.Controls(
            airplay: .enabled,
            audible: Props.MediaGroupControl(options: []),
            camera: nil,
            error: nil,
            legible: .external(
                external: .none,
                control: Props.MediaGroupControl(options: [Props.Option(
                    name: "Option1",
                    selected: true,
                    select: .nop)])),
            live: Props.Live(
                isHidden: true,
                dotColor: nil),
            loading: false,
            pictureInPictureControl: .possible(.nop),
            playbackAction: .play(.nop),
            seekbar: Props.Seekbar(
                duration: 1800,
                currentTime: 0,
                progress: 0,
                buffered: 0.2,
                seeker: Props.Seeker(
                    seekTo: .nop,
                    state: Props.State(
                        start: .nop,
                        update: .nop,
                        stop: .nop))),
            settings: .enabled(.nop),
            sideBarViewHidden: false,
            thumbnail: nil,
            title: "Short Video"))))
}
