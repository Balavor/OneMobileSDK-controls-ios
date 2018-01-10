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
    @IBOutlet private var subtitlesAirplayTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesEdgeTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesPipTrailingConstrains: NSLayoutConstraint!
    
    //MARK: Animators
    
    @IBOutlet var shadowAnimator: FadeAnimator!
    
    @IBOutlet var playAnimator: FadeAnimator!
    @IBOutlet var pauseAnimator: FadeAnimator!
    @IBOutlet var replayAnimator: FadeAnimator!
    @IBOutlet var retryAnimator: FadeAnimator!
    @IBOutlet var nextAnimator: FadeAnimator!
    @IBOutlet var prevAnimator: FadeAnimator!
    @IBOutlet var seekTo10SecBackwardAnimator: FadeAnimator!
    @IBOutlet var seekTo10SecForwardAnimator: FadeAnimator!
    @IBOutlet var airplayLabelAnimator: FadeAnimator!
    @IBOutlet var errorAnimator: FadeAnimator!
    @IBOutlet var subtitlesAnimator: FadeAnimator!
    
    @IBOutlet var compasBodyAnimator: FadeAnimator!
    @IBOutlet var compasDirectionAnimator: FadeAnimator!
    @IBOutlet var liveAnimator: FadeAnimator!
    
    @IBOutlet var airplayViewAnimator: FadeAnimator!
    @IBOutlet var settingsAnimator: FadeAnimator!
    @IBOutlet var pipAnimator: FadeAnimator!
    @IBOutlet var titleAnimator: FadeAnimator!
    @IBOutlet var durationAnimator: FadeAnimator!
    
    @IBOutlet var seekerFadeAnimator: FadeAnimator!
    @IBOutlet var seekerSlideAnimator: SlideAnimator!
    @IBOutlet var bottomItemsAnimator: SlideAnimator!
    @IBOutlet var sideBarAnimator: SlideAnimator!

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
    
    
    var centerAnimatorGroup = AnimatorGroup()
    var slideBottomAnimatorGroup = AnimatorGroup()
    var isViewAppeared: Bool = false
    var areControlsHidden: Bool = false
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isViewAppeared = true
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isViewAppeared = false
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
        shadowAnimator.maxAlpha = 0.3
        centerAnimatorGroup.animators = [shadowAnimator, playAnimator, pauseAnimator, replayAnimator, retryAnimator, seekTo10SecBackwardAnimator, compasBodyAnimator, airplayLabelAnimator, errorAnimator]
        slideBottomAnimatorGroup.animators = [sideBarAnimator, bottomItemsAnimator]
    }
    
    var task: URLSessionDataTask?
    
    var uiProps: UIProps = UIProps(props: .noPlayer, controlsViewVisible: false)
    //swiftlint:disable function_body_length
    //swiftlint:disable cyclomatic_complexity
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        areControlsHidden = uiProps.controlsViewHidden
        
        uiProps = UIProps(props: props,
                          controlsViewVisible: controlsShouldBeVisible)
        
        isLoading = uiProps.loading
        
        nextButton.isEnabled = uiProps.nextButtonEnabled
        prevButton.isEnabled = uiProps.prevButtonEnabled
        
        seekerView.updateCurrentTime(text: uiProps.seekerViewCurrentTimeText)
        seekerView.progress = uiProps.seekerViewProgress
        seekerView.buffered = uiProps.seekerViewBuffered
        
        let constant = traitCollection.userInterfaceIdiom == .pad ? 70 : 63
        bottomSeekBarConstraint.constant = uiProps.seekbarPositionedAtBottom
            ? 13
            : CGFloat(constant)
        
        compasDirectionView.transform = uiProps.compasDirectionViewTransform
        cameraPanGestureRecognizer.isEnabled = uiProps.cameraPanGestureIsEnabled
        
        videoTitleLabel.text = uiProps.videoTitleLabelText
        
        durationTextLabel.text = uiProps.durationTextLabelText
        
        ccTextLabel.text = uiProps.subtitlesTextLabelText

        visibleControlsSubtitlesConstraint.constant = uiProps.controlsViewHidden ? 30 : 110
        airplayPipTrailingConstrains.isActive = !uiProps.pipButtonHidden
        airplayEdgeTrailingConstrains.isActive = uiProps.pipButtonHidden
        subtitlesAirplayTrailingConstrains.isActive = !uiProps.airplayButtonHidden 
        subtitlesEdgeTrailingConstrains.isActive = uiProps.airplayButtonHidden && uiProps.pipButtonHidden
        subtitlesPipTrailingConstrains.isActive = uiProps.airplayButtonHidden
        
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
        
        errorLabel.text = uiProps.errorLabelText
        
        pipButton.isEnabled = uiProps.pipButtonEnabled
        
        settingsButton.isEnabled = uiProps.settingsButtonEnabled
        
        liveDotLabel.textColor = uiProps.liveDotColor ?? liveDotLabel.textColor ?? view.tintColor
        
        airPlayView.props = AirPlayView.Props(
            icons: AirPlayView.Props.Icons(
                normal: UIImage.init(named: "icon-airplay", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!,
                selected: UIImage.init(named: "icon-airplay-active", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!,
                highlighted: UIImage.init(named: "icon-airplay-active", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!)
        )
        
        //MARK: Animators
        
        playAnimator.isHidden = uiProps.playButtonHidden
        pauseAnimator.isHidden = uiProps.pauseButtonHidden
        replayAnimator.isHidden = uiProps.replayButtonHidden
        retryAnimator.isHidden = uiProps.retryButtonHidden
        nextAnimator.isHidden = uiProps.nextButtonHidden
        prevAnimator.isHidden = uiProps.prevButtonHidden
        seekTo10SecBackwardAnimator.isHidden = uiProps.seekBackButtonHidden
        seekTo10SecForwardAnimator.isHidden = uiProps.seekForwardButtonHidden
        airplayLabelAnimator.isHidden = uiProps.airplayActiveLabelHidden
        errorAnimator.isHidden = uiProps.errorLabelHidden
        subtitlesAnimator.isHidden = uiProps.subtitlesTextLabelHidden
        
        compasBodyAnimator.isHidden = uiProps.compasBodyViewHidden
        compasDirectionAnimator.isHidden = uiProps.compasDirectionViewHidden
        liveAnimator.isHidden = uiProps.liveIndicationViewIsHidden
        
        airplayViewAnimator.isHidden = uiProps.airplayButtonHidden
        settingsAnimator.isHidden = uiProps.settingsButtonHidden
        pipAnimator.isHidden = uiProps.pipButtonHidden
        titleAnimator.isHidden = uiProps.videoTitleLabelHidden
        durationAnimator.isHidden = uiProps.durationTextHidden
        
        seekerFadeAnimator.isHidden = uiProps.seekerViewHidden

        //MARK: Animator groups
        
        guard isViewAppeared else { return }
        if areControlsHidden != uiProps.controlsViewHidden {
            controlsAnimationGroup.performAnimaiton(forState: uiProps.controlsViewHidden)
        } else {
            
        }
        // if view appeared
        //     if uiProps.controlsViewHidden == previous state
        //         use personal fade animation
        //     else
        //         use group animators
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
        self.view.setNeedsLayout()
    }
    
    public func hideControls() {
        controlsShouldBeVisible = false
        self.view.setNeedsLayout()
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
