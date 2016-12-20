//
//  MusicPlayer.swift
//  MindfulMoment
//
//  Created by Christopher Boynton on 12/20/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import Foundation
import AVFoundation

class MusicManager {
    
    private init() {}
    static let shared = MusicManager()
    
    var audioPlayer = AVAudioPlayer()
    
    var songTimer = Timer()
    
    @objc func startSong() {
        
        let rand = arc4random_uniform(4)
        let songURL: URL
        
        switch rand {
        case 0:
            songURL = URL(fileURLWithPath: Bundle.main.path(forResource: "01Ataraxia", ofType: "mp3")!)
            songTimer = Timer.scheduledTimer(timeInterval: 788.74, target: self, selector: #selector(startSong), userInfo: nil, repeats: false)
        case 1:
            songURL = URL(fileURLWithPath: Bundle.main.path(forResource: "02The_Ambient_Ukulele", ofType: "mp3")!)
            songTimer = Timer.scheduledTimer(timeInterval: 777.33, target: self, selector: #selector(startSong), userInfo: nil, repeats: false)
        case 2:
            songURL = URL(fileURLWithPath: Bundle.main.path(forResource: "03Illuminations", ofType: "mp3")!)
            songTimer = Timer.scheduledTimer(timeInterval: 459.23, target: self, selector: #selector(startSong), userInfo: nil, repeats: false)
        case 3:
            songURL = URL(fileURLWithPath: Bundle.main.path(forResource: "04Squinting_at_the_Sun", ofType: "mp3")!)
            songTimer = Timer.scheduledTimer(timeInterval: 790.13, target: self, selector: #selector(startSong), userInfo: nil, repeats: false)
        default:
            songURL = URL(fileURLWithPath: Bundle.main.path(forResource: "01Ataraxia", ofType: "mp3")!)
            songTimer = Timer.scheduledTimer(timeInterval: 788.74, target: self, selector: #selector(startSong), userInfo: nil, repeats: false)
        }
    
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("FAILURE: Error with setting up AVAudioSession")
        }
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: songURL)
            audioPlayer.prepareToPlay()
            audioPlayer.setVolume(0, fadeDuration: 0)
            audioPlayer.play()
            audioPlayer.setVolume(1, fadeDuration: 3)
        } catch {
            print("FAILURE: Error with setting up audio player")
        }
        
    }
    
    func stopSong() {
        audioPlayer.setVolume(0, fadeDuration: 3)
    }
    
}
