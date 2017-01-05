//
//  NGTProgressView.swift
//  PullRefresh
//
//  Created by Naveen George Thoppan on 28/12/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit
@IBDesignable
public class NGTProgressView: UIView {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var sunImageView: UIImageView!
    @IBOutlet weak var signBoardImageView: UIImageView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var cityLeadingConstriant: NSLayoutConstraint!
    
    var isCompleted: Bool!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        backgroundColor = .clear
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return nibView
    }
    
    public func startAnimation(completion: @escaping (_ isCompleted: Bool)->()) {
        isCompleted = false
        rotateView(targetView: sunImageView)
        animateRefreshStep2() { (isCompleted) -> () in
            if isCompleted == true {
                completion(isCompleted)
            }
        }
    }
    
    public func animateRefreshStep2(completion: @escaping (_ isCompleted: Bool)->()) {
        self.carLeadingConstraint.constant = self.view.bounds.width/2 - 30
        self.cityLeadingConstriant.constant -= 15
        UIView.animate(withDuration: 4, animations: {
            self.view.layoutIfNeeded()
            self.startCarShakeAnimation()
        }) { finished in
            completion(true)
        }
    }
    
    public func stopAnimation (completion: @escaping (_ isCompleted: Bool)->()) {
        if (self.isCompleted == false) {
            self.carLeadingConstraint.constant = self.view.bounds.width + 30
            self.cityLeadingConstriant.constant -= 15
            UIView.animate(withDuration: 2, delay:0.8, animations: {
                self.view.layoutIfNeeded()
                
                
            }) { finished in
                self.isCompleted = true
                self.stopCarShakeAnimation()
                completion(self.isCompleted)
                self.carLeadingConstraint.constant = -90
                self.cityLeadingConstriant.constant = -37
            }
        }
    }
    private func rotateView(targetView: UIView, duration: Double = 2) {
        UIView.animate(withDuration: duration, delay: 0.0, options: [.repeat, .curveLinear], animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat(M_PI))
        })
    }
    
    public func startCarShakeAnimation () {
        let carShakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        carShakeAnimation.duration = 0.1
        carShakeAnimation.beginTime = CACurrentMediaTime() + 1
        carShakeAnimation.autoreverses = true
        carShakeAnimation.repeatDuration = 20
        carShakeAnimation.fromValue = -0.1;
        carShakeAnimation.toValue = 0.1
        self.carImageView.layer.add(carShakeAnimation, forKey: "carAnimation")
        
    }
    
    public func stopCarShakeAnimation () {
        self.carImageView.layer.removeAnimation(forKey: "carAnimation")
    }
}
