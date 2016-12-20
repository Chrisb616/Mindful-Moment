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
    
    func playRandomSong() {
        
        let rand = arc4random_uniform(4)
        let songURL: URL
        
        switch rand {
        case 0:
            songURL = URL(fileURLWithPath: Bundle.main.path(forResource: "01Ataraxia", ofType: "mp3")!)
        case 1:
            songURL = URL(fileURLWithPath: Bundle.main.path(forResource: "02The_Ambient_Ukulele", ofType: "mp3")!)
        case 2:
            songURL = URL(fileURLWithPath: Bundle.main.path(forResource: "03Illuminations", ofType: "mp3")!)
        case 3:
            songURL = URL(fileURLWithPath: Bundle.main.path(forResource: "04Squinting_at_the_Sun", ofType: "mp3")!)
        default:
            songURL = URL(fileURLWithPath: Bundle.main.path(forResource: "01Ataraxia", ofType: "mp3")!)
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
    
}
