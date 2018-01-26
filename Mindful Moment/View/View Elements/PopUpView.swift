//
//  TimerCompletionView.swift
//  Mindful Moment
//
//  Created by Christopher Boynton on 1/26/18.
//  Copyright © 2018 Christopher Boynton. All rights reserved.
//

import UIKit

class PopUpView: UIView {
    
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    //MARK: - Other View Elements
    weak var viewPresentedOn: UIView?
    
    static func present(onView superview: UIView, withTitle title: String, body: String) -> PopUpView {
        let nib = UINib(nibName: "PopUpView", bundle: Bundle.main)
        let view = nib.instantiate(withOwner: self, options: nil).first as! PopUpView
        
        view.viewPresentedOn = superview
        superview.fadeAndDisable()
        
        superview.addSubview(view)
        
        view.frame = CGRect(x: 0, y: 0, width: superview.frame.width * 0.75, height: superview.frame.width * 0.75)
        view.center = superview.center
        
        view.standardFormat()
        view.leftButton.isHidden = true
        view.centerButton.isHidden = true
        view.rightButton.isHidden = true
        
        view.titleLabel.text = title
        view.bodyTextView.text = body
        
        return view
    }
    
    deinit {
        viewPresentedOn?.removeFadeAndReenable()
    }
    
    private func formatFromNib() {
        leftButton.standardFormat()
        centerButton.standardFormat()
        rightButton.standardFormat()
    }
    
    func formatLeftButton(text: String, selector: Selector) {
        leftButton.setTitle(text, for: .normal)
        leftButton.addTarget(nil, action: selector, for: .touchUpInside)
        
        leftButton.isHidden = false
    }
    
    func formatCenterButton(text: String, selector: Selector) {
        centerButton.setTitle(text, for: .normal)
        centerButton.addTarget(nil, action: selector, for: .touchUpInside)
        
        centerButton.isHidden = false
    }
    
    func formatRightButton(text: String, selector: Selector) {
        rightButton.setTitle(text, for: .normal)
        rightButton.addTarget(nil, action: selector, for: .touchUpInside)
        
        rightButton.isHidden = false
    }

}
