//
//  ConstellationView.swift
//  MindfulMoment
//
//  Created by Christopher Boynton on 12/13/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import UIKit

class ConstellationView: UIView {
    
    var starViews = [StarView]()
    
    override func layoutSubviews() {
        
        
    }
    
    func layoutStars() {
        
        layoutFirstStar()
        
        for _ in 1..<numberOfStars {
            layoutStar()
        }
        
        for star in starViews {
            let randomRotation = Double(arc4random_uniform(360))
            
            star.transform = CGAffineTransform(rotationDegrees: randomRotation)
            
            star.twinkleDuration = Double(arc4random_uniform(1000))/100 + 10
            star.twinkle()
        }
    }
    
    private func layoutFirstStar() {
        print("Laying out star number 1")
        let newStar = StarView()
        
        self.addSubview(newStar)
        
        let randomPercentSize: CGFloat = CGFloat(arc4random_uniform(150))/100
        
        newStar.frame = CGRect(x: self.frame.width / 2, y: self.frame.height / 2, width: self.frame.width * 0.1 * randomPercentSize, height: self.frame.width * 0.1 * randomPercentSize)
        
        starViews.append(newStar)
        
    }
    
    
    private func layoutStar() {
        let newStar = StarView()
        
        self.addSubview(newStar)
        
        let referenceStar = starViews.randomElement()
        
        var randomXOffset: CGFloat = CGFloat(arc4random_uniform(100)) - 50
        
        if randomXOffset > 0 {
            randomXOffset += 20
        } else {
            randomXOffset -= 20
        }
        
        var randomYOffset: CGFloat = CGFloat(arc4random_uniform(200)) - 100
        
        if randomYOffset > 0 {
            randomYOffset += 20
        } else {
            randomYOffset -= 20
        }
        
        let randomPercentSize: CGFloat = CGFloat(arc4random_uniform(150))/100
        
        newStar.frame = CGRect(x: referenceStar.frame.origin.x,
                               y: referenceStar.frame.origin.y,
                               width: self.frame.width * 0.1 * randomPercentSize,
                               height: self.frame.width * 0.1 * randomPercentSize)
        
        newStar.center.x += randomXOffset
        newStar.center.y += randomYOffset
        
        if !self.bounds.contains(newStar.frame) {
            newStar.removeFromSuperview()
            return
            
        }
        
        for star in starViews {
            if newStar.frame.intersects(star.frame) {
                newStar.removeFromSuperview()
                return
            }
        }
        
        starViews.append(newStar)
    }
    
//    private func layoutStar() {
//        
//        print("Laying out star number \(starViews.count+1)")
//        let newStar = StarView()
//        
//        self.addSubview(newStar)
//        
//        let referenceStar = starViews.randomElement()
//        
//        var randomXOffset = CGFloat(arc4random_uniform(UInt32(referenceStar.frame.width * 4))) - referenceStar.frame.width * 8
//        var randomYOffset = CGFloat(arc4random_uniform(UInt32(referenceStar.frame.width * 4))) - referenceStar.frame.width * 8
//        
//        if randomXOffset < 20 && randomXOffset > -20 {
//            if randomXOffset >= 0 {
//                randomXOffset = 20
//            } else {
//                randomXOffset = -20
//            }
//        }
//        
//        if randomYOffset < 20 && randomYOffset > -20 {
//            if randomYOffset >= 0 {
//                randomYOffset = 20
//            } else {
//                randomYOffset = -20
//            }
//        }
//        
//        print("Offset x:\(randomXOffset), y: \(randomYOffset) ")
//        
//        let randomPercentSize: CGFloat = CGFloat(arc4random_uniform(150))/100
//        
//        newStar.frame = CGRect(x: referenceStar.center.x + randomXOffset,
//                               y: referenceStar.center.y + randomYOffset,
//                               width: self.frame.width * 0.1 * randomPercentSize,
//                               height: self.frame.width * 0.1 * randomPercentSize)
//        
//        
//        var doesIntersect = false
//        
//        
//        
//        for starView in starViews {
//            if newStar.center.distance(to: starView.center) < 10 {
//                doesIntersect = true
//                print("POINT: Intersects, with distance of \(newStar.center.distance(to: starView.center))")
//            } else {
//                print("POINT: Doesn't intersect, with distance of \(newStar.center.distance(to: starView.center))")
//            }
//        }
//        
//        
//        newStar.backgroundColor = UIColor.red
//        
//        if doesIntersect {
//            newStar.removeFromSuperview()
//            layoutStar()
//        } else {
//        }
//        
//        
//        
//    }
    
    var numberOfStars: Int {
        let random = Int(arc4random_uniform(5))
        
        return random + 10
    }
}
