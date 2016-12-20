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
            audioPlayer.play()
        } catch {
            print("FAILURE: Error with setting up audio player")
        }
        
    }
    
}
