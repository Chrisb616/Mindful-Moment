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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(constellationTL)
        self.view.addSubview(constellationTR)
        self.view.addSubview(constellationBL)
        self.view.addSubview(constellationBR)
        
//        constellationTL.alpha = 0
//        constellationTR.alpha = 0
//        constellationBL.alpha = 0
//        constellationBR.alpha = 0
        
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
    let skyGradient = CAGradientLayer()
    let oceanGradient = CAGradientLayer()
    
    func setUpGradients() {
        
        let bright = UIColor.themeTealAccent1.cgColor
        let dark = UIColor.nightTeal.cgColor
        
        skyGradient.colors = [dark, dark, bright, bright, bright, dark, dark]
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
        
        skyAnimation.values = [startKeyframe,dawnKeyframe,noonKeyframe,duskKeyframe,endKeyframe]
        skyAnimation.keyTimes = [0,0.1,0.5,0.9,1]
        skyAnimation.duration = 30
        skyGradient.add(skyAnimation, forKey: "locations")
        
        
        
        let bright = UIColor.themeTealAccent1.cgColor
        let dark = UIColor.nightTeal.cgColor
        let twilight = UIColor.twilight.cgColor
        let dawnOrange = UIColor.sunRiseOrange.cgColor
        //let dawnRed = UIColor.sunRiseRed.cgColor
        
        let skyColorAnimation = CAKeyframeAnimation(keyPath: "colors")
        
        let startColorKeyFrame = [dark, dark, bright, bright, bright, dark, dark]
        let dawnColorKeyFrame = [dark, twilight, dawnOrange, dawnOrange, dawnOrange, dark, dark]
        let morningColorKeyFrame = [twilight, dawnOrange, bright, bright, bright, dark, dark]
        
        skyColorAnimation.values = [startColorKeyFrame,dawnColorKeyFrame,morningColorKeyFrame,startColorKeyFrame,startColorKeyFrame]
        skyColorAnimation.keyTimes = [0,0.1,0.25,1,1]
        skyColorAnimation.duration = 30
        skyGradient.add(skyColorAnimation, forKey: "colors")
        print("Finished Sky Animation")
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
        oceanAnimation.duration = 30
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
                self.view.layoutIfNeeded()
            })
            
            
            endTimer()
            HealthManager.saveMeditation(start: startTime, end: endTime)
            
        } else {
            print("Start Button Tapped")
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            startLabel.text = "Stop"
            
            UIView.animate(withDuration: 0.5, animations: {
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.pastButton.alpha = 0
                self.view.layoutIfNeeded()
            })
            
            countIsActive = true
            startTimer()
            
            initialAnimateStars()
        }
        
    }
    
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
        
        
    }
    func endTimer() {
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
    }
    func updateTime(_ sender: Timer) {
        if secondsInTime % 60 == 0 {
            animateSun()
        }
        if secondsInTime % 60 == 15 {
            animateStars()
        }
        if secondsInTime % 60 == 30 {
            animateMoon()
        }
        secondsInTime += 1
        timerLabel.text = secondsInTime.convertedToTime
        
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
    
    func animateSun() {
        animateSkyGradient()
        animateOceanGradient()
        
        let sun = SunView()
        
        self.view.addSubview(sun)
        
        sun.animateRays()
        
        sun.frame = CGRect(x: self.view.frame.width, y: self.view.frame.height, width: self.view.frame.width * 0.4, height: self.view.frame.width * 0.4)
        
        let sunPath = UIBezierPath()
        sunPath.move(to: CGPoint(x: self.view.frame.width * 2, y: self.view.frame.height))
        sunPath.addQuadCurve(to: CGPoint(x: self.view.frame.width * -1, y: self.view.frame.height) , controlPoint: CGPoint(x: self.view.frame.width/2, y: self.view.frame.height * -0.77))
        
        
        let sunArcAnimation = CAKeyframeAnimation(keyPath: "position")
        sunArcAnimation.path = sunPath.cgPath
        sunArcAnimation.repeatCount = 0
        sunArcAnimation.duration = 30.0
        
        sun.layer.add(sunArcAnimation, forKey: "position")
        
        
        
    }
    
    func animateMoon() {
        let updatedMoonPhase = advanceMoonPhase()
        
        moonPhase = updatedMoonPhase
        
        
        let moon = MoonView()
        
        self.view.addSubview(moon)
        
        moon.moonImageView = UIImageView(image: updatedMoonPhase.image)
        
        moon.frame = CGRect(x: self.view.frame.width, y: self.view.frame.height, width: self.view.frame.width * 0.305, height: self.view.frame.width * 0.305)
        
    
        let moonPath = UIBezierPath()
        moonPath.move(to: CGPoint(x: self.view.frame.width * 2, y: self.view.frame.height))
        moonPath.addQuadCurve(to: CGPoint(x: self.view.frame.width * -1, y: self.view.frame.height) , controlPoint: CGPoint(x: self.view.frame.width/2, y: self.view.frame.height * -0.83))
        
        
        let moonArcAnimation = CAKeyframeAnimation(keyPath: "position")
        moonArcAnimation.path = moonPath.cgPath
        moonArcAnimation.repeatCount = 0
        moonArcAnimation.duration = 30.0
        
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
        UIView.animate(withDuration: 15, animations: {
            self.constellationTR.alpha = 0
            self.constellationTL.alpha = 0
            self.constellationBL.alpha = 0
            self.constellationBR.alpha = 0
        }) { (finished) in
            self.constellationTR.alpha = 0
            self.constellationTL.alpha = 0
            self.constellationBL.alpha = 0
            self.constellationBR.alpha = 0
        }
    }
    
    func animateStars() {
        UIView.animateKeyframes(withDuration: 60, delay: 0, options: [.calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/6, animations: {
                self.constellationTR.alpha = 1
                self.constellationTL.alpha = 1
                self.constellationBL.alpha = 1
                self.constellationBR.alpha = 1
            })
            UIView.addKeyframe(withRelativeStartTime: 5/6, relativeDuration: 1/6, animations: {
                self.constellationTR.alpha = 0
                self.constellationTL.alpha = 0
                self.constellationBL.alpha = 0
                self.constellationBR.alpha = 0
            })
        })
    }
}

    
    
    
