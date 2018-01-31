import MediaPlayer
//  Copyright © 2017 Oath. All rights reserved.
/// This class contains all controls that
/// are defined for Player View Controller default UI.
/// You can replace commands with your own
/// and customise controls according to your needs.
public final class DefaultControlsViewController: ContentControlsViewController, CAAnimationDelegate {
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
    @IBOutlet private var loadingImageView: UIImageView!
    @IBOutlet private var sideBarView: SideBarView!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var retryButton: UIButton!
    @IBOutlet private var cameraPanGestureRecognizer: UIPanGestureRecognizer!
    
    
    @IBOutlet private var bottomItemsView: BottomItemsView!
    @IBOutlet private var pipButton: UIButton!
    @IBOutlet private var settingsButton: UIButton!
    @IBOutlet private var airPlayView: AirPlayView!
    @IBOutlet private var videoTitleLabel: UILabel!
    
    @IBOutlet private var liveIndicationView: UIView!
    @IBOutlet private var liveDotLabel: UILabel!
    
    //MARK: Slide constraints
    @IBOutlet private var bottomItemsViewConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomItemsToPlayerBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var seekerPushingBottomItemaConstraint: NSLayoutConstraint!
    
    @IBOutlet private var visibleControlsSubtitlesConstraint: NSLayoutConstraint!
    @IBOutlet private var compassBodyBelowLiveTopConstraint: NSLayoutConstraint!
    @IBOutlet private var compassBodyNoLiveTopConstraint: NSLayoutConstraint!
    @IBOutlet private var airplayPipTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var airplayEdgeTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesAirplayTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesEdgeTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesPipTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet private var sideBarConstraints: AnimationsConstraint!
    
    public var animationEnabled = false
    
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
    
    var isApperared = false
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isApperared = true
    }
    var task: URLSessionDataTask?
    
    var uiProps: UIProps = UIProps(props: .noPlayer, controlsViewVisible: false)
    //swiftlint:disable function_body_length
    //swiftlint:disable cyclomatic_complexity
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        uiProps = UIProps(props: props,
                          controlsViewVisible: controlsShouldBeVisible)
        
        if animationEnabled {
            let oldState = BottomItemsState(seekerViewHidden: true, airplayButtonHidden: uiProps.airplayButtonHidden, pipButtonHidden: true, settingsButtonHidden: true, videoTitleLabelHidden: true)
            let newState = BottomItemsState(seekerViewHidden: true, airplayButtonHidden: uiProps.airplayButtonHidden, pipButtonHidden: true, settingsButtonHidden: true, videoTitleLabelHidden: true)
            
            bottomItemsView.bottomItemsNewState = newState
            bottomItemsView.airplayBuuton = airPlayView
            
            performFadeAnimation(for: shadowView, inHiddenState: uiProps.controlsViewHidden)
            performFadeAnimation(for: playButton, inHiddenState: uiProps.playButtonHidden)
            performFadeAnimation(for: pauseButton, inHiddenState: uiProps.pauseButtonHidden)
            performFadeAnimation(for: replayButton, inHiddenState: uiProps.replayButtonHidden)
            performFadeAnimation(for: nextButton, inHiddenState: uiProps.nextButtonHidden)
            performFadeAnimation(for: prevButton, inHiddenState: uiProps.prevButtonHidden)
            performFadeAnimation(for: seekBackButton, inHiddenState: uiProps.seekBackButtonHidden)
            performFadeAnimation(for: seekForwardButton, inHiddenState: uiProps.seekForwardButtonHidden)
            performFadeAnimation(for: compasBodyView, inHiddenState: uiProps.compasBodyViewHidden)
            performFadeAnimation(for: compasDirectionView, inHiddenState: uiProps.compasDirectionViewHidden)
            performFadeAnimation(for: retryButton, inHiddenState: uiProps.retryButtonHidden)
            performFadeAnimation(for: errorLabel, inHiddenState: uiProps.errorLabelHidden)
            performFadeAnimation(for: liveIndicationView, inHiddenState: uiProps.liveIndicationViewIsHidden)
            performFadeAnimation(for: airplayActiveLabel, inHiddenState: uiProps.airplayActiveLabelHidden)
            
            performSideBarAnimation(isHidden: uiProps.sideBarViewHidden)
            
            let seekerBarAnimationType = seekerAnimationType(bottomItemsOldState: bottomItemsView.isHidden, bottomItemsNewState: uiProps.bottomItemsHidden)
            performSeekerAnimation(animation: seekerBarAnimationType, inHidden: uiProps.seekerViewHidden)
        
        } else {
            shadowView.isHidden = uiProps.controlsViewHidden
            playButton.isHidden = uiProps.playButtonHidden
            pauseButton.isHidden = uiProps.pauseButtonHidden
            replayButton.isHidden = uiProps.replayButtonHidden
            nextButton.isHidden = uiProps.nextButtonHidden
            prevButton.isHidden = uiProps.prevButtonHidden
            seekBackButton.isHidden = uiProps.seekBackButtonHidden
            seekForwardButton.isHidden = uiProps.seekForwardButtonHidden
            compasBodyView.isHidden = uiProps.compasBodyViewHidden
            compasDirectionView.isHidden = uiProps.compasDirectionViewHidden
            retryButton.isHidden = uiProps.retryButtonHidden
            errorLabel.isHidden = uiProps.errorLabelHidden
            liveIndicationView.isHidden = uiProps.liveIndicationViewIsHidden
            airplayActiveLabel.isHidden = uiProps.airplayActiveLabelHidden
            
            sideBarView.isHidden = uiProps.sideBarViewHidden
            seekerView.isHidden = uiProps.seekerViewHidden
        }
    
        isLoading = uiProps.loading
    
        nextButton.isEnabled = uiProps.nextButtonEnabled
        prevButton.isEnabled = uiProps.prevButtonEnabled
        
        //MARK: BottomItems
        let constant = traitCollection.userInterfaceIdiom == .pad ? 70 : 63
        if uiProps.controlsViewHidden {
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.airplayPipTrailingConstrains.isActive = !self.uiProps.pipButtonHidden
                self.airplayEdgeTrailingConstrains.isActive = self.uiProps.pipButtonHidden
                self.subtitlesAirplayTrailingConstrains.isActive = !self.uiProps.airplayButtonHidden
                self.subtitlesEdgeTrailingConstrains.isActive = self.uiProps.airplayButtonHidden && self.uiProps.pipButtonHidden
                self.subtitlesPipTrailingConstrains.isActive = self.uiProps.airplayButtonHidden
            })
            performBottomItemsSlideAnimation(inHidden: uiProps.controlsViewHidden, withConstant: constant)
            CATransaction.commit()
        } else {
            performBottomItemsSlideAnimation(inHidden: uiProps.controlsViewHidden, withConstant: constant)
            airplayPipTrailingConstrains.isActive = !uiProps.pipButtonHidden
            airplayEdgeTrailingConstrains.isActive = uiProps.pipButtonHidden
            subtitlesAirplayTrailingConstrains.isActive = !uiProps.airplayButtonHidden
            subtitlesEdgeTrailingConstrains.isActive = uiProps.airplayButtonHidden && uiProps.pipButtonHidden
            subtitlesPipTrailingConstrains.isActive = uiProps.airplayButtonHidden
        }
        
        
        seekerView.updateCurrentTime(text: uiProps.seekerViewCurrentTimeText)
        seekerView.progress = uiProps.seekerViewProgress
        seekerView.buffered = uiProps.seekerViewBuffered
        
        compasDirectionView.transform = uiProps.compasDirectionViewTransform
        cameraPanGestureRecognizer.isEnabled = uiProps.cameraPanGestureIsEnabled
        
        videoTitleLabel.text = uiProps.videoTitleLabelText
        
        durationTextLabel.text = uiProps.durationTextLabelText
        
        ccTextLabel.isHidden = uiProps.subtitlesTextLabelHidden
        ccTextLabel.text = uiProps.subtitlesTextLabelText

        visibleControlsSubtitlesConstraint.constant = uiProps.controlsViewHidden ? 30 : 110

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
        } else if let image = uiProps.thumbnailImage {
            thumbnailImageView.isHidden = false
            thumbnailImageView.image = image
        }
        
        
        errorLabel.text = uiProps.errorLabelText
        //MARK: Buttons
        pipButton.isHidden = uiProps.pipButtonHidden
        pipButton.isEnabled = uiProps.pipButtonEnabled
        
        settingsButton.isHidden = uiProps.settingsButtonHidden
        settingsButton.isEnabled = uiProps.settingsButtonEnabled
        
        
        liveDotLabel.textColor = uiProps.liveDotColor ?? liveDotLabel.textColor ?? view.tintColor
        
        
        airPlayView.props = AirPlayView.Props(
            icons: AirPlayView.Props.Icons(
                normal: UIImage.init(named: "icon-airplay", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!,
                selected: UIImage.init(named: "icon-airplay-active", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!,
                highlighted: UIImage.init(named: "icon-airplay-active", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!)
        )
        airPlayView.isHidden = uiProps.airplayButtonHidden
    }
    
    var animationDuration: CFTimeInterval = 0.4
    
    func performFadeAnimation(for view: UIView, inHiddenState state: Bool) {
        let animation = CATransition()
        animation.type = kCATransitionFade
        animation.duration = animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(animation, forKey: "hidden")
        view.isHidden = state
    }
    
    func performSeekerAnimation(animation: AnimationType, inHidden state: Bool) {
        switch (animation) {
        case (.none):
            seekerView.isHidden = state
        case (.fade):
            print("fade seeker")
            let animation = CATransition()
            animation.type = kCATransitionFade
            animation.duration = animationDuration
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            seekerView.layer.add(animation, forKey: "hidden")
            seekerView.isHidden = state
        }
    }
    
    func performBottomItemsSlideAnimation(inHidden state: Bool, withConstant constant: Int) {
        switch state {
        case true:
            CATransaction.begin()
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = animationDuration
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            self.bottomItemsView.layer.add(animation, forKey: "position")
            bottomItemsViewConstraint.constant = -(CGFloat(constant) + bottomItemsView.frame.height + seekerView.frame.height)
            CATransaction.commit()
        case false:
            CATransaction.begin()
            bottomItemsView.isHidden = false
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = animationDuration
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            bottomItemsView.layer.add(animation, forKey: "position")
            bottomItemsViewConstraint.constant = 0
            CATransaction.commit()
        }
    }
    
    func performSideBarAnimation(isHidden: Bool) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.4
        switch isHidden {
        case true:
            CATransaction.setCompletionBlock({
                self.sideBarView.isHidden = true
                self.sideBarConstraints.toggleToVisible()
            })
            self.sideBarView.layer.add(animation, forKey: "position")
            self.sideBarConstraints.toggleToInVisible()
            
        case false:
            sideBarConstraints.toggleToInVisible()
            sideBarView.isHidden = false
            
            CATransaction.flush()
            
            self.sideBarView.layer.add(animation, forKey: "position")
            self.sideBarConstraints.toggleToVisible()

        }
        //CATransaction.flush()
        print("sidebar\(sideBarView.isHidden)")
    }
    
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

