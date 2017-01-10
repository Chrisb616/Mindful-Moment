//
//  ViewController.swift
//  Flatiron Presents Health Kit App
//
//  Created by Christopher Boynton on 10/24/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let healthStore = HealthManager.healthStore
    let store = DataStore.sharedInstance
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    let startButtonTapGesture = UIGestureRecognizer()
    
    @IBOutlet weak var pastButton: UIButton!
    @IBOutlet weak var pastMindfulnessSessionLabel: UILabel!
    
    let timerLabel = UILabel()
    let meditationSavedLabel = UILabel()
    
    var countIsActive = false
    
    var timer = Timer()
    var secondsInTime = 0
    
    var startTime = Date()
    var endTime = Date()
    
    @IBOutlet weak var ocean: UIView!
    @IBOutlet weak var mountain: UIImageView!
    @IBOutlet weak var mountain2: UIImageView!
    @IBOutlet weak var mountain3: UIImageView!
    @IBOutlet weak var openingMoon: UIImageView!
    @IBOutlet weak var openingSun: UIImageView!
    @IBOutlet weak var openingSunRays: UIImageView!
    
    var moonPhase = MoonView.MoonPhase.new
    
    var sessions = [Session]()
    
    let constellationTL = ConstellationView()
    let constellationTR = ConstellationView()
    let constellationBL = ConstellationView()
    let constellationBR = ConstellationView()
    
    private let musicManager = MusicManager.shared
    
    var infoLabel = UILabel()
    var infoButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(infoButton)
        infoButton.frame = CGRect(x: 20, y: 30, width: self.view.frame.width * 0.15, height: self.view.frame.width * 0.15)
        infoButton.addTarget(self, action: #selector(showInfo), for: .touchUpInside)
        
        infoButton.addFittedSubview(infoLabel)
        infoLabel.text = Icon.Library.info.rawValue
        infoLabel.font = Icon.Size.medium.font
        infoLabel.textAlignment = .center
        infoLabel.textColor = UIColor.sunGlare
        
        
        openingSun.isHidden = true
        openingSunRays.isHidden = true
        openingMoon.isHidden = true
        
        self.view.addSubview(constellationTL)
        self.view.addSubview(constellationTR)
        self.view.addSubview(constellationBL)
        self.view.addSubview(constellationBR)
        
        constellationTL.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: self.view.frame.width / 2)
        constellationTR.frame = CGRect(x: self.view.frame.width / 2, y: 0, width: self.view.frame.width / 2, height: self.view.frame.width / 2)
        constellationBL.frame = CGRect(x: 0, y: self.view.frame.width / 2, width: self.view.frame.width / 2, height: self.view.frame.width / 2)
        constellationBR.frame = CGRect(x: self.view.frame.width / 2, y: self.view.frame.width / 2, width: self.view.frame.width / 2, height: self.view.frame.width / 2)
        
        self.view.sendSubview(toBack: constellationTL)
        self.view.sendSubview(toBack: constellationTR)
        self.view.sendSubview(toBack: constellationBL)
        self.view.sendSubview(toBack: constellationBR)
        
        constellationTL.layoutStars()
        constellationTR.layoutStars()
        constellationBL.layoutStars()
        constellationBR.layoutStars()
        
        
        setUpViews()
        openingAnimation()
        
        let queue = OperationQueue()
        
        queue.addOperation {
            HealthManager.setUpHealthStore()
        }
        
        print("View Did load")
        
        self.view.layoutIfNeeded()
        
        store.getMeditationsFromHeath {}
        setUpGradients()
        
    }
    
    func showInfo() {
        present(InfoViewController(), animated: true)
    }
    
    let skyGradient = CAGradientLayer()
    let oceanGradient = CAGradientLayer()
    
    func setUpGradients() {

        let dark = UIColor.nightTeal.cgColor
        
        skyGradient.colors = [dark, dark, dark, dark, dark, dark, dark]
        skyGradient.locations = [0,1,1,1,1,1,1]
        skyGradient.startPoint = CGPoint(x: -1, y: 0)
        skyGradient.endPoint = CGPoint(x: 2, y: 0)
        skyGradient.frame = self.view.frame
        self.view.layer.insertSublayer(skyGradient, at: 0)
        skyGradient.bounds = self.view.bounds
        
        let sunGlareOcean = UIColor.sunGlare.cgColor
        let dayOcean = UIColor.dayOcean.cgColor
        let nightOcean = UIColor.nightOcean.cgColor
        
        oceanGradient.colors = [nightOcean, nightOcean, dayOcean, sunGlareOcean, sunGlareOcean, sunGlareOcean, dayOcean, nightOcean, nightOcean]
        oceanGradient.locations = [0,1,1,1,1,1,1,1,1]
        oceanGradient.startPoint = CGPoint(x: -1, y: 0)
        oceanGradient.endPoint = CGPoint(x: 2, y: 0)
        oceanGradient.frame = self.view.frame
        self.ocean.layer.insertSublayer(oceanGradient, at: 0)
        oceanGradient.bounds = self.view.bounds
    }
    func animateSkyGradient() {
        let skyAnimation = CAKeyframeAnimation(keyPath: "locations")
        
        let startKeyframe = [0,1,1,1,1,1,1]
        let dawnKeyframe = [0,0.5,1,1,1,1,1]
        let noonKeyframe = [0,0,0,0.5,1,1,1]
        let duskKeyframe = [0,0,0,0,0,0.5,1]
        let endKeyframe = [0,0,0,0,0,0,1]
        
        skyAnimation.values = [startKeyframe,dawnKeyframe,noonKeyframe,noonKeyframe,duskKeyframe,endKeyframe]
        skyAnimation.keyTimes = [0,0.1,0.3,0.7,0.95,1]
        skyAnimation.duration = 30 * timerMult
        skyGradient.add(skyAnimation, forKey: "locations")
        
        
        
        let bright = UIColor.themeTealAccent1.cgColor
        let day = UIColor.themeTeal.cgColor
        let dark = UIColor.nightTeal.cgColor
        let twilight = UIColor.twilight.cgColor
        let dawnOrange = UIColor.sunRiseOrange.cgColor
        //let dawnRed = UIColor.sunRiseRed.cgColor
        
        let skyColorAnimation = CAKeyframeAnimation(keyPath: "colors")
        
        let startColorKeyFrame = [dark, dark, bright, bright, bright, dark, dark]
        let dawnColorKeyFrame = [dark, twilight, dawnOrange, dawnOrange, dawnOrange, dark, dark]
        let morningColorKeyFrame = [twilight, dawnOrange, bright, bright, bright, dark, dark]
        let noonColorKeyFrame = [dark,dark,day,day,day,dark,dark]
        let afternoonColorKeyFrame = [dark,dark,day,day,dawnOrange,twilight,twilight]
        let duskColorKeyFrame = [dark,dark,dawnOrange,dawnOrange,dawnOrange,twilight,twilight]
        
        skyColorAnimation.values = [startColorKeyFrame,dawnColorKeyFrame,morningColorKeyFrame,noonColorKeyFrame,afternoonColorKeyFrame,duskColorKeyFrame,startColorKeyFrame]
        skyColorAnimation.keyTimes = [0,0.1,0.25,0.5,0.75,0.9,1]
        skyColorAnimation.duration = 30 * timerMult
        skyGradient.add(skyColorAnimation, forKey: "colors")
        print("Finished Sky Animation")
        
        
        
        let skyGradientStartAnimation = CAKeyframeAnimation(keyPath: "startPoint")
        
        let gradientStartStartFrame = CGPoint(x: -1, y: -1)
        let gradientStartMidFrame = CGPoint(x: -1, y: 0)
        let gradientStartEndFrame = CGPoint(x: -1, y: 2)
        
        skyGradientStartAnimation.values = [gradientStartStartFrame, gradientStartMidFrame,gradientStartEndFrame]
        skyGradientStartAnimation.keyTimes = [0,0.5,1]
        skyGradientStartAnimation.duration = 30 * timerMult
        skyGradient.add(skyGradientStartAnimation, forKey: "startPoint")
        
        
        let skyGradientEndAnimation = CAKeyframeAnimation(keyPath: "endPoint")
        
        let gradientEndStartFrame = CGPoint(x: 2, y: 2)
        let gradientEndMidFrame = CGPoint(x: 2, y: 0)
        let gradientEndEndFrame = CGPoint(x: 2, y: -1)
        
        skyGradientEndAnimation.values = [gradientEndStartFrame, gradientEndMidFrame,gradientEndEndFrame]
        skyGradientEndAnimation.keyTimes = [0,0.5,1]
        skyGradientEndAnimation.duration = 30 * timerMult
        skyGradient.add(skyGradientEndAnimation, forKey: "endPoint")
        

    }
    func animateOceanGradient() {
        print("Ocean animating")
        let oceanAnimation = CAKeyframeAnimation(keyPath: "locations")
        
        let startKeyframe = [0,1,1,1,1,1,1,1,1]
        let dawnKeyframe =  [0,0.5,1,1,1,1,1,1,1]
        let noonKeyframe =  [0,0,0,0.4,0.5,0.6,1,1,1]
        let duskKeyframe =  [0,0,0,0,0,0,0,0.5,1]
        let endKeyframe =  [0,0,0,0,0,0,0,0,1]
        
        oceanAnimation.values = [startKeyframe,dawnKeyframe,noonKeyframe,duskKeyframe,endKeyframe]
        oceanAnimation.keyTimes = [0,0.1,0.5,0.9,1]
        oceanAnimation.duration = 30 * timerMult
        oceanGradient.add(oceanAnimation, forKey: "locations")
    }
    
    func setUpViews() {
        print(startButton.allTargets)
        startButton.layer.cornerRadius = 10
        startButton.layer.borderColor = UIColor.themePurple.cgColor
        startButton.layer.borderWidth = 3
        startButton.layer.shadowColor = UIColor.black.cgColor
        startButton.layer.shadowOpacity = 1
        startButton.layer.shadowOffset = CGSize(width: 2, height: 5)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        print(startButton.allTargets)
        startButton.addSubview(startLabel)
        
        
        self.view.addSubview(timerLabel)
        timerLabel.text = "00:00"
        timerLabel.textAlignment = .center
        timerLabel.textColor = UIColor.themeYellow
        timerLabel.font = UIFont.timerLabelFont
        timerLabel.frame = CGRect(x: 0, y: self.view.frame.midY * 1.25, width: self.view.frame.width, height: self.view.frame.height * 0.2)
        timerLabel.alpha = 0
        
        self.view.addSubview(meditationSavedLabel)
        meditationSavedLabel.text = "Session Saved"
        meditationSavedLabel.textAlignment = .center
        meditationSavedLabel.textColor = UIColor.themeYellow
        meditationSavedLabel.font = UIFont.smallTextFont
        meditationSavedLabel.frame = CGRect(x: 0, y: self.view.frame.midY * 1.35, width: self.view.frame.width, height: self.view.frame.height * 0.2)
        meditationSavedLabel.alpha = 0
        
        pastButton.layer.cornerRadius = 10
        pastButton.layer.borderColor = UIColor.themePurple.cgColor
        pastButton.layer.borderWidth = 3
        pastButton.layer.shadowColor = UIColor.black.cgColor
        pastButton.layer.shadowOpacity = 1
        pastButton.layer.shadowOffset = CGSize(width: 2, height: 5)
        pastButton.addSubview(pastMindfulnessSessionLabel)
        pastButton.addTarget(self, action: #selector(pastButtonTapped), for: .touchUpInside)
    }
    
    func openingAnimation(){
        openingSun.addSubview(openingSunRays)
        
        UIView.animate(withDuration: 5) {
            self.mountain.transform = CGAffineTransform(translationX: 0, y: 150)
            self.mountain2.transform = CGAffineTransform(translationX: 0, y: 200)
            self.mountain3.transform = CGAffineTransform(translationX: 0, y: 200)
            self.openingMoon.transform = CGAffineTransform(translationX: 50, y: -180)
            self.openingSun.transform = CGAffineTransform(translationX: -50, y: -180)
            self.openingSunRays.transform = CGAffineTransform(rotationDegrees: 70)
        }

    }
    
    func startButtonTapped(_ sender: UIButton) {
        
        
        if countIsActive {
            countIsActive = false
            
            print("Stop Button Tapped")
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            startLabel.text = "Start"
            
            UIView.animate(withDuration: 0.5, animations: {
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.pastButton.alpha = 1
                self.infoButton.alpha = 1
                self.view.layoutIfNeeded()
            })
            
            
            endTimer()
            musicManager.stopSong()
            HealthManager.saveMeditation(start: startTime, end: endTime)
            
        } else {
            print("Start Button Tapped")
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            startLabel.text = "Stop"
            
            UIView.animate(withDuration: 0.5, animations: {
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.pastButton.alpha = 0
                self.infoButton.alpha = 0
                self.view.layoutIfNeeded()
            })
            
            countIsActive = true
            startTimer()
            musicManager.startSong()
            
            //initialAnimateStars()
        }
        
    }
    
    let timerMult: Double = 10
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        startTime = Date()
        timerLabel.text = "00:00"
        meditationSavedLabel.alpha = 0
        
        
        UIView.animateKeyframes(withDuration: 5, delay: 0, options: [.calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 2/5, animations: {
                self.timerLabel.alpha = 1
                self.timerLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            })
            UIView.addKeyframe(withRelativeStartTime: 3/5, relativeDuration: 2/5, animations: {
                self.timerLabel.alpha = 0
            })
        })
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    func endTimer() {
        resetViews()
        timer.invalidate()
        endTime = Date()
        secondsInTime = 0
        timerLabel.alpha = 1
        meditationSavedLabel.alpha = 1
        
        UIView.animateKeyframes(withDuration: 5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 4/5, relativeDuration: 1/5, animations: {
                self.timerLabel.alpha = 0
            })
        })
        
        UIApplication.shared.isIdleTimerDisabled = false
        
        timeUntilNextAnimation = 0
        animationTiming = 0
    }
    
    func resetViews() {
        let resetSkyColors = CABasicAnimation(keyPath: "colors")
        
        let dark = UIColor.nightTeal
        
        resetSkyColors.toValue = [dark, dark, dark, dark, dark, dark, dark]
        resetSkyColors.duration = 3
        
        skyGradient.add(resetSkyColors, forKey: "colors")
        
        let resetOceanColors = CABasicAnimation(keyPath: "colors")
        
        let nightOcean  = UIColor.nightOcean
        
        resetOceanColors.toValue = [nightOcean,nightOcean,nightOcean,nightOcean,nightOcean,nightOcean,nightOcean,nightOcean,nightOcean]
        resetOceanColors.duration = 3
        
        oceanGradient.add(resetOceanColors, forKey: "colors")
        
        
        let resetStarAlpha = CABasicAnimation(keyPath: "opacity")
        
        resetStarAlpha.toValue = 1
        resetStarAlpha.duration = 3
        
        constellationTR.layer.add(resetStarAlpha, forKey: "opacity")
        constellationBR.layer.add(resetStarAlpha, forKey: "opacity")
        constellationTL.layer.add(resetStarAlpha, forKey: "opacity")
        constellationBL.layer.add(resetStarAlpha, forKey: "opacity")
        
        
        
        let fadeSun = CABasicAnimation(keyPath: "opacity")
        
        fadeSun.toValue = 0
        fadeSun.duration = 3
        
        sun.layer.add(fadeSun, forKey: "opacity")
        
        Timer.scheduledTimer(withTimeInterval: 2.9, repeats: false) { (timer) in
            self.sun.layer.opacity = 0
        }
        
        let fadeMoon = CABasicAnimation(keyPath: "opacity")
        
        fadeMoon.toValue = 0
        fadeMoon.duration = 3
        
        moon.layer.add(fadeMoon, forKey: "opacity")
        
        oceanGradient.removeAllAnimations()
        
        Timer.scheduledTimer(withTimeInterval: 2.9, repeats: false) { (timer) in
            self.moon.layer.opacity = 0
        }
    }
    
    func updateTime(_ sender: Timer) {
        secondsInTime += 1
        timerLabel.text = secondsInTime.convertedToTime
        animationTimer()
    }
    
    var animationTiming: Int = 0
    var timeUntilNextAnimation: Int = 0
    
    func animationTimer() {
        
        if timeUntilNextAnimation == 0 {
            
            
            if animationTiming % 60 == 0 {
                animateSun()
                animateStars()
                //fadeOutStars()
            }
            if animationTiming % 60 == 23 {
                //fadeInStars()
            }
            if animationTiming % 60 == 30 {
                animateMoon()
            }
            if animationTiming % 60 == 50 {
            }
            
            animationTiming += 1
            
            timeUntilNextAnimation = Int(timerMult)
        }
        
        timeUntilNextAnimation -= 1
        
        
        
    }
    func pastButtonTapped() {
        print("Past Button Tapped")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath)
        
        return cell
    }
    
    let sun = SunView()
    
    func animateSun() {
        animateSkyGradient()
        animateOceanGradient()
        
        sun.layer.opacity = 1
        
        self.view.addSubview(sun)
        
        sun.animateRays()
        
        sun.frame = CGRect(x: self.view.frame.width, y: self.view.frame.height, width: self.view.frame.width * 0.4, height: self.view.frame.width * 0.4)
        
        let sunPath = UIBezierPath()
        sunPath.move(to: CGPoint(x: self.view.frame.width * 2, y: self.view.frame.height))
        sunPath.addQuadCurve(to: CGPoint(x: self.view.frame.width * -1, y: self.view.frame.height) , controlPoint: CGPoint(x: self.view.frame.width/2, y: self.view.frame.height * -0.77))
        
        
        let sunArcAnimation = CAKeyframeAnimation(keyPath: "position")
        sunArcAnimation.path = sunPath.cgPath
        sunArcAnimation.repeatCount = 0
        sunArcAnimation.duration = 30.0 * timerMult
        
        sun.layer.add(sunArcAnimation, forKey: "position")
        
        
    }
    
    var moon = MoonView()
    
    func animateMoon() {
        moon = MoonView()
        
        moon.layer.opacity = 1
        
        let updatedMoonPhase = advanceMoonPhase()
        
        moonPhase = updatedMoonPhase
        print(moonPhase)
        
        
        
        self.view.addSubview(moon)
        
        moon.moonImageView = UIImageView(image: updatedMoonPhase.image)
        
        moon.frame = CGRect(x: self.view.frame.width, y: self.view.frame.height, width: self.view.frame.width * 0.305, height: self.view.frame.width * 0.305)
        
    
        let moonPath = UIBezierPath()
        moonPath.move(to: CGPoint(x: self.view.frame.width * 2, y: self.view.frame.height))
        moonPath.addQuadCurve(to: CGPoint(x: self.view.frame.width * -1, y: self.view.frame.height) , controlPoint: CGPoint(x: self.view.frame.width/2, y: self.view.frame.height * -0.83))
        
        
        let moonArcAnimation = CAKeyframeAnimation(keyPath: "position")
        moonArcAnimation.path = moonPath.cgPath
        moonArcAnimation.repeatCount = 0
        moonArcAnimation.duration = 30.0 * timerMult
        
        moon.layer.add(moonArcAnimation, forKey: "position")
    }

    
    func advanceMoonPhase() -> MoonView.MoonPhase {
        switch moonPhase {
        case .new: return .waxingCrescent
        case .waxingCrescent: return .firstQuarter
        case .firstQuarter: return .waxingGibbous
        case .waxingGibbous: return .full
        case .full: return .waningGibbous
        case .waningGibbous: return .thirdQuarter
        case .thirdQuarter: return .waningCrescent
        case .waningCrescent: return .new
        }
    }
    func initialAnimateStars() {
        let fadeOutStars = CABasicAnimation(keyPath: "opacity")
        
        fadeOutStars.fromValue = 1
        fadeOutStars.toValue = 0
        fadeOutStars.duration = 5 * timerMult
        
        constellationBL.layer.add(fadeOutStars, forKey: "opacity")
        constellationBR.layer.add(fadeOutStars, forKey: "opacity")
        constellationTL.layer.add(fadeOutStars, forKey: "opacity")
        constellationTR.layer.add(fadeOutStars, forKey: "opacity")
        
        Timer.scheduledTimer(withTimeInterval: 5 * timerMult, repeats: false) { (timer) in
            self.constellationTR.layer.opacity = 0
            self.constellationTL.layer.opacity = 0
            self.constellationBL.layer.opacity = 0
            self.constellationBR.layer.opacity = 0
            print("Faded")
        }
    }
    
    func animateStars() {
        let fadeInOutStars = CAKeyframeAnimation(keyPath: "opacity")
        
        fadeInOutStars.values = [1,0,0,1]
        fadeInOutStars.keyTimes = [0,NSNumber(floatLiteral: 5/60),NSNumber(floatLiteral: 25/60),NSNumber(floatLiteral: 30/60)]
        
        fadeInOutStars.duration = 60 * timerMult
        
        constellationBR.layer.add(fadeInOutStars, forKey: "opacity")
        constellationTR.layer.add(fadeInOutStars, forKey: "opacity")
        constellationBL.layer.add(fadeInOutStars, forKey: "opacity")
        constellationTL.layer.add(fadeInOutStars, forKey: "opacity")
    }
    
    func fadeOutStars() {
        let fadeOutStars = CABasicAnimation(keyPath: "opacity")
        
        fadeOutStars.fromValue = 1
        fadeOutStars.toValue = 0
        fadeOutStars.duration = 5 * timerMult
        
        constellationBL.layer.add(fadeOutStars, forKey: "opacity")
        constellationBR.layer.add(fadeOutStars, forKey: "opacity")
        constellationTL.layer.add(fadeOutStars, forKey: "opacity")
        constellationTR.layer.add(fadeOutStars, forKey: "opacity")
        
        Timer.scheduledTimer(withTimeInterval: 4.9 * timerMult, repeats: false) { (timer) in
            self.constellationTR.layer.opacity = 0
            self.constellationTL.layer.opacity = 0
            self.constellationBL.layer.opacity = 0
            self.constellationBR.layer.opacity = 0
            print("Faded")
        }
    }
    
    func fadeInStars() {
        let fadeInStars = CABasicAnimation(keyPath: "opacity")
        
        fadeInStars.fromValue = 0
        fadeInStars.toValue = 1
        fadeInStars.duration = 5 * timerMult
        
        constellationBL.layer.add(fadeInStars, forKey: "opacity")
        constellationBR.layer.add(fadeInStars, forKey: "opacity")
        constellationTL.layer.add(fadeInStars, forKey: "opacity")
        constellationTR.layer.add(fadeInStars, forKey: "opacity")
        
        Timer.scheduledTimer(withTimeInterval: 4.9 * timerMult, repeats: false) { (timer) in
            self.constellationTR.layer.opacity = 1
            self.constellationTL.layer.opacity = 1
            self.constellationBL.layer.opacity = 1
            self.constellationBR.layer.opacity = 1
            print("Faded")
        }
    }
}

    
    
    
