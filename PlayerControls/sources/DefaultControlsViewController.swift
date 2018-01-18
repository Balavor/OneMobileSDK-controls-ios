import MediaPlayer
//  Copyright © 2017 Oath. All rights reserved.
/// This class contains all controls that
/// are defined for Player View Controller default UI.
/// You can replace commands with your own
/// and customise controls according to your needs.
public final class DefaultControlsViewController: ContentControlsViewController {
    public init() {
        super.init(nibName: "DefaultControlsViewController",
                   bundle: Bundle(for: type(of: self)))
        setupVisibilityController()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(nibName: "DefaultControlsViewController",
                   bundle: Bundle(for: type(of: self)))
        setupVisibilityController()
    }
    
    public override var props: Props {
        didSet(old) {
            guard isViewLoaded else { return }
            updateVisibilityController(from: old, to: props)
        }
    }
    
    @IBOutlet private var airplayActiveLabel: UILabel!
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var controlsView: UIView!
    @IBOutlet private var shadowView: UIView!
    @IBOutlet private var compasDirectionView: UIView!
    @IBOutlet private var compasBodyView: UIView!
    @IBOutlet private var ccTextLabel: UILabel!
    @IBOutlet private var playButton: UIButton!
    @IBOutlet private var pauseButton: UIButton!
    @IBOutlet private var replayButton: UIButton!
    @IBOutlet private var nextButton: UIButton!
    @IBOutlet private var prevButton: UIButton!
    @IBOutlet private var durationTextLabel: UILabel!
    @IBOutlet private var seekerView: SeekerControlView!
    @IBOutlet private var seekForwardButton: UIButton!
    @IBOutlet private var seekBackButton: UIButton!
    @IBOutlet private var videoTitleLabel: UILabel!
    @IBOutlet private var loadingImageView: UIImageView!
    @IBOutlet private var sideBarView: SideBarView!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var retryButton: UIButton!
    @IBOutlet private var cameraPanGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet private var pipButton: UIButton!
    @IBOutlet private var settingsButton: UIButton!
    @IBOutlet private var airPlayView: AirPlayView!
    
    @IBOutlet private var liveIndicationView: UIView!
    @IBOutlet private var liveDotLabel: UILabel!
    
    @IBOutlet private var visibleControlsSubtitlesConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomSeekBarConstraint: NSLayoutConstraint!
    @IBOutlet private var compassBodyBelowLiveTopConstraint: NSLayoutConstraint!
    @IBOutlet private var compassBodyNoLiveTopConstraint: NSLayoutConstraint!
    @IBOutlet private var airplayPipTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var airplayEdgeTrailingConstrains: NSLayoutConstraint!
    //@IBOutlet private var subtitlesAirplayTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesEdgeTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesPipTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesAirplayTrailingConstrains: NSLayoutConstraint!
    
    @IBOutlet private var settingConstraints: Constraints!
    @IBOutlet private var airplayConstraints: Constraints!
    
    public var sidebarProps: SideBarView.Props = [] {
        didSet {
            sideBarView.props = sidebarProps.map { [weak self] in
                var props = $0
                let handler = props.handler
                props.handler = CommandWith {
                    self?.onUserInteraction?.perform()
                    handler.perform()
                }
                return props
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        seekerView.callbacks.onDragStarted = CommandWith { [unowned self] value in
            self.startSeek(from: value)
        }
        seekerView.callbacks.onDragChanged = CommandWith { [unowned self] value in
            self.updateSeek(to: value)
        }
        seekerView.callbacks.onDragFinished = CommandWith { [unowned self] value in
            self.stopSeek(at: value)
        }
    }
    
    var task: URLSessionDataTask?
    var apearedOnce: Bool = false
    
    var uiProps: UIProps = UIProps(props: .noPlayer, controlsViewVisible: false)
    //swiftlint:disable function_body_length
    //swiftlint:disable cyclomatic_complexity
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        apearedOnce = true
    }
    enum AnimationType {
        case fade, slide, move, `none`
    }
    
    func performSettingsButtonAnimation(type: AnimationType, isHidden: Bool) {
        switch (type, isHidden) {
        case (.fade, true):
            print("Set in fade out")
            settingsButton.alpha = 1
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.curveLinear],
                           animations: {
                            self.settingsButton.alpha = 0
                            self.view.layoutIfNeeded() },
                           completion: { _ in self.settingsButton.isHidden = isHidden })
            
        case (.fade, false):
            print("Set in fade in")
            settingsButton.alpha = 0
            settingsButton.isHidden = false
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.curveLinear],
                           animations: { self.settingsButton.alpha = 1 },
                           completion: nil)
            
        case (.slide, true):
            print("Set in slide down")
            settingConstraints.activeConstraints.forEach { $0.isActive = false }
            settingConstraints.inavtiveConstraints.forEach { $0.isActive = true }
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.curveEaseIn],
                           animations: self.view.layoutIfNeeded,
                           completion: { _ in
                            self.settingsButton.isHidden = isHidden
                            self.settingConstraints.inavtiveConstraints.forEach { $0.isActive = false }
                            self.settingConstraints.activeConstraints.forEach { $0.isActive = true }})
            
        case (.slide, false):
            print("Set in slide up")
            settingConstraints.activeConstraints.forEach { $0.isActive = false }
            settingConstraints.inavtiveConstraints.forEach { $0.isActive = true }
            
            airPlayView.isHidden = isHidden
            self.view.layoutIfNeeded()
            
            settingConstraints.inavtiveConstraints.forEach { $0.isActive = false }
            settingConstraints.activeConstraints.forEach { $0.isActive = true }
            
            self.settingsButton.isHidden = false
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.curveEaseIn],
                           animations: self.view.layoutIfNeeded,
                           completion: nil)
            
        case (.move, _):
            print("Set in move")
            return
            
        case (.none, _):
            return
        }
    }
    
    func performAirPlayButtonAnimation(type: AnimationType, isHidden: Bool) {
        switch (type, isHidden) {
        case (.fade, true):
            print("AP in fade out")
            airPlayView.alpha = 1
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.curveLinear],
                           animations: {
                            self.airPlayView.alpha = 0
                            self.view.layoutIfNeeded() },
                           completion: { _ in self.airPlayView.isHidden = isHidden })
            
        case (.fade, false):
            print("AP in fade in")
            airPlayView.alpha = 0
            airPlayView.isHidden = isHidden
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.curveLinear],
                           animations: { self.airPlayView.alpha = 1 },
                           completion: nil)
            
        case (.slide, true):
            print("AP in slide down")
            airplayConstraints.activeConstraints.forEach { $0.isActive = false }
            airplayConstraints.inavtiveConstraints.forEach { $0.isActive = true }
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.curveEaseIn],
                           animations: self.view.layoutIfNeeded,
                           completion: { _ in
                            self.airPlayView.isHidden = isHidden
                            self.airplayConstraints.inavtiveConstraints.forEach { $0.isActive = !isHidden }
                            self.airplayConstraints.activeConstraints.forEach { $0.isActive = isHidden } })
            
        case (.slide, false):
            print("AP in slide up")
            airplayConstraints.activeConstraints.forEach { $0.isActive = isHidden }
            airplayConstraints.inavtiveConstraints.forEach { $0.isActive = !isHidden }
            
            airPlayView.isHidden = isHidden
            self.view.layoutIfNeeded()
            
            airplayConstraints.inavtiveConstraints.forEach { $0.isActive = isHidden }
            airplayConstraints.activeConstraints.forEach { $0.isActive = !isHidden }
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.curveEaseIn, .beginFromCurrentState],
                           animations: self.view.layoutIfNeeded,
                           completion: nil)
            
        case (.move, _):
            print("AP in move")
            return
            
        case (.none, _):
            print("AP does nothing")
            return
        }
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        uiProps = UIProps(props: props,
                          controlsViewVisible: controlsShouldBeVisible)
        
        let currenState = BottomItemsState(seekerViewHidden: seekerView.isHidden,
                                           airplayButtonHidden: airPlayView.isHidden,
                                           pipButtonHidden: pipButton.isHidden,
                                           settingsButtonHidden: settingsButton.isHidden,
                                           videoTitleLabelHidden: videoTitleLabel.isHidden)
        
        let futureState = BottomItemsState(seekerViewHidden: uiProps.seekerViewHidden,
                                           airplayButtonHidden: uiProps.airplayButtonHidden,
                                           pipButtonHidden: uiProps.pipButtonHidden,
                                           settingsButtonHidden: uiProps.settingsButtonHidden,
                                           videoTitleLabelHidden: uiProps.videoTitleLabelHidden)
        
        let animationTypes = determineBottomAnimationType(from: currenState, to: futureState)
        
        controlsView.isHidden = uiProps.controlsViewHidden
        isLoading = uiProps.loading
        
        playButton.isHidden = uiProps.playButtonHidden
        pauseButton.isHidden = uiProps.pauseButtonHidden
        replayButton.isHidden = uiProps.replayButtonHidden
        
        nextButton.isHidden = uiProps.nextButtonHidden
        nextButton.isEnabled = uiProps.nextButtonEnabled
        prevButton.isHidden = uiProps.prevButtonHidden
        prevButton.isEnabled = uiProps.prevButtonEnabled
        
        seekerView.isHidden = uiProps.seekerViewHidden
        seekerView.updateCurrentTime(text: uiProps.seekerViewCurrentTimeText)
        seekerView.progress = uiProps.seekerViewProgress
        seekerView.buffered = uiProps.seekerViewBuffered
        
        let constant = traitCollection.userInterfaceIdiom == .pad ? 70 : 63
        bottomSeekBarConstraint.constant = uiProps.seekbarPositionedAtBottom
            ? 13
            : CGFloat(constant)
        
        seekBackButton.isHidden = uiProps.seekBackButtonHidden
        seekForwardButton.isHidden = uiProps.seekForwardButtonHidden
        
        sideBarView.isHidden = uiProps.sideBarViewHidden
        
        compasBodyView.isHidden = uiProps.compasBodyViewHidden
        compasDirectionView.isHidden = uiProps.compasDirectionViewHidden
        compasDirectionView.transform = uiProps.compasDirectionViewTransform
        cameraPanGestureRecognizer.isEnabled = uiProps.cameraPanGestureIsEnabled
        
        videoTitleLabel.isHidden = uiProps.videoTitleLabelHidden
        videoTitleLabel.text = uiProps.videoTitleLabelText
        
        durationTextLabel.text = uiProps.durationTextLabelText
        durationTextLabel.isHidden = uiProps.durationTextHidden
        
        ccTextLabel.isHidden = uiProps.subtitlesTextLabelHidden
        ccTextLabel.text = uiProps.subtitlesTextLabelText
        
        visibleControlsSubtitlesConstraint.constant = uiProps.controlsViewHidden ? 30 : 110
        
        //subtitlesAirplayTrailingConstrains.isActive = !uiProps.airplayButtonHidden
        subtitlesEdgeTrailingConstrains.isActive = uiProps.airplayButtonHidden && uiProps.pipButtonHidden
        subtitlesPipTrailingConstrains.isActive = uiProps.airplayButtonHidden
        airplayPipTrailingConstrains.isActive = !self.uiProps.pipButtonHidden
        airplayEdgeTrailingConstrains.isActive = self.uiProps.pipButtonHidden
        
        thumbnailImageView.isHidden = uiProps.thumbnailImageViewHidden
        
        if let url = uiProps.thumbnailImageUrl {
            func resetUrlIfNeeded() {
                guard let taskUrl = task?.originalRequest?.url else { return }
                guard taskUrl != url else { return }
                task = nil
            }
            
            func handleThumbnail() {
                guard task == nil else { return }
                weak var weakSelf = self
                task = URLSession.shared.dataTask(
                    with: url,
                    completionHandler: { data, response, error in
                        guard let response = response as? HTTPURLResponse else { return }
                        guard response.statusCode == 200 else { return }
                        guard error == nil else { return }
                        guard let data = data else { return }
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            weakSelf?.thumbnailImageView.isHidden = false
                            weakSelf?.thumbnailImageView.image = image
                        }
                })
                task?.resume()
            }
            
            resetUrlIfNeeded()
            handleThumbnail()
        }
        
        retryButton.isHidden = uiProps.retryButtonHidden
        errorLabel.isHidden = uiProps.errorLabelHidden
        errorLabel.text = uiProps.errorLabelText
        
        pipButton.isHidden = uiProps.pipButtonHidden
        pipButton.isEnabled = uiProps.pipButtonEnabled
        
        if apearedOnce {
            performSettingsButtonAnimation(type: animationTypes.settingsAnimationType, isHidden: uiProps.settingsButtonHidden)
        } else {
            settingsButton.isHidden = uiProps.settingsButtonHidden
        }
        settingsButton.isEnabled = uiProps.settingsButtonEnabled
        
        liveIndicationView.isHidden = uiProps.liveIndicationViewIsHidden
        liveDotLabel.textColor = uiProps.liveDotColor ?? liveDotLabel.textColor ?? view.tintColor
        
        airplayActiveLabel.isHidden = uiProps.airplayActiveLabelHidden
        airPlayView.props = AirPlayView.Props(
            icons: AirPlayView.Props.Icons(
                normal: UIImage.init(named: "icon-airplay", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!,
                selected: UIImage.init(named: "icon-airplay-active", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!,
                highlighted: UIImage.init(named: "icon-airplay-active", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!)
        )
        if apearedOnce {
            performAirPlayButtonAnimation(type: animationTypes.airplayAnimationType, isHidden: uiProps.airplayButtonHidden)
        } else {
            airPlayView.isHidden = uiProps.airplayButtonHidden
        }
    }
    
    //swiftlint:enable function_body_length
    //swiftlint:enable cyclomatic_complexity
    
    /// Alpha for shadow view.
    public var shadowViewAlpha = 0.3 as CGFloat
    
    /// Shadow view on beneath controls.
    @IBInspectable var isLoading: Bool = false {
        didSet {
            guard isViewLoaded else { return }
            
            loadingImageView.isHidden = !isLoading
            
            isLoading
                ? loadingImageView.enableRotation()
                : loadingImageView.disableRotation()
        }
    }
    
    public var onPlayEvent: Command?
    public var onPauseEvent: Command?
    public var onTapEvent: Command?
    public var onUserInteraction: Command?
    
    func updateVisibilityController( //swiftlint:disable:this cyclomatic_complexity
        from old: ContentControlsViewController.Props,
        to new: ContentControlsViewController.Props) {
        
        func isVideoPlaying(for props: ContentControlsViewController.Props) -> Bool {
            guard case .player(let player) = props else { return false }
            guard case .playable(let contentProps) = player.item else { return false }
            guard case .pause = contentProps.playbackAction else { return false }
            return true
        }
        
        switch (isVideoPlaying(for: old), isVideoPlaying(for: new)) {
        case (true, true): break
        case (false, false): break
        case (false, true): onPlayEvent?.perform()
        case (true, false): onPauseEvent?.perform()
        }
    }
    
    var controlsShouldBeVisible = true
    
    public func showControls() {
        controlsShouldBeVisible = true
        view.setNeedsLayout()
    }
    
    public func hideControls() {
        controlsShouldBeVisible = false
        view.setNeedsLayout()
    }
    
    func setupVisibilityController() {
        weak var weakSelf = self
        let controls = ControlsPresentationController.Controls(
            show: CommandWith { weakSelf?.showControls() },
            hide: CommandWith { weakSelf?.hideControls() })
        
        let visibilityController = ControlsPresentationController(controls: controls)
        
        onUserInteraction = CommandWith { visibilityController.resetTimer() }
        onTapEvent = CommandWith { visibilityController.tap() }
        onPlayEvent = CommandWith { visibilityController.play() }
        onPauseEvent = CommandWith { visibilityController.pause() }
    }
    
    @IBAction private func playButtonTouched() {
        uiProps.playButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func pauseButtonTouched() {
        uiProps.pauseButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func replayButtonTouched() {
        uiProps.replayButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func nextButtonTouched() {
        uiProps.nextButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func prevButtonTouched() {
        uiProps.prevButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    private func startSeek(from progress: CGFloat) {
        uiProps.startSeekAction.perform(with: .init(progress))
        onUserInteraction?.perform()
    }
    
    private func updateSeek(to progress: CGFloat) {
        uiProps.updateSeekAction.perform(with: .init(progress))
        onUserInteraction?.perform()
    }
    
    private func stopSeek(at progress: CGFloat) {
        uiProps.stopSeekAction.perform(with: .init(progress))
        onUserInteraction?.perform()
    }
    
    @IBAction private func seekForwardButtonTouched() {
        uiProps.seekToSecondsAction.perform(with: uiProps.seekerViewCurrentTime.advanced(by: 10))
        onUserInteraction?.perform()
    }
    
    @IBAction private func seekBackButtonTouched() {
        let value = uiProps.seekerViewCurrentTime
        uiProps.seekToSecondsAction.perform(with: value - min(value, 10))
        onUserInteraction?.perform()
    }
    
    @IBAction private func onEmptySpaceTap() {
        onTapEvent?.perform()
    }
    
    @IBAction private func onCameraPan(with recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: recognizer.view)
        recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
        
        uiProps.updateCameraAngles.perform(with: translation)
    }
    
    @IBAction private func resetCamera() {
        uiProps.resetCameraAngles.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func retry() {
        uiProps.retryButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func pipButtonTouched() {
        uiProps.pipButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func settingsButtonTouched() {
        uiProps.settingsButtonAction.perform()
    }
}

