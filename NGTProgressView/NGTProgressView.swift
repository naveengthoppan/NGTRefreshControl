//
//  NGTProgressView.swift
//  PullRefresh
//
//  Created by Naveen George Thoppan on 28/12/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit
 @IBDesignable
class NGTProgressView: UIView {
        
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var sunImageView: UIImageView!
    @IBOutlet weak var signBoardImageView: UIImageView!
    @IBOutlet weak var carImageView: UIImageView!
    
    var isCompleted: Bool!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            nibSetup()
        }
        
        required init?(coder aDecoder: NSCoder) {
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
        
        UIView.animate(withDuration: 4, animations: {
            self.carImageView.center.x = self.view.bounds.width/2
            self.cityImageView.center.x -= 15
            self.startCarShakeAnimation()
        }) { finished in
            completion(true)
        }
    }
    
    public func stopAnimation (completion: @escaping (_ isCompleted: Bool)->()) {
            if (self.isCompleted == false) {
                UIView.animate(withDuration: 2, delay:0.8, animations: {
                    self.carImageView.center.x = self.view.bounds.width+60
                    self.cityImageView.center.x -= 15
                    
                }) { finished in
                    self.isCompleted = true
                    self.stopCarShakeAnimation()
                    completion(self.isCompleted)
                }
            }
    }
    private func rotateView(targetView: UIView, duration: Double = 2) {
        UIView.animate(withDuration: duration, delay: 0.0, options: [.repeat, .curveLinear], animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat(M_PI))
        })
    }
    
    func startCarShakeAnimation () {
        let carShakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        carShakeAnimation.duration = 0.1
        carShakeAnimation.beginTime = CACurrentMediaTime() + 1
        carShakeAnimation.autoreverses = true
        carShakeAnimation.repeatDuration = 20
        carShakeAnimation.fromValue = -0.1;
        carShakeAnimation.toValue = 0.1
        self.carImageView.layer.add(carShakeAnimation, forKey: "carAnimation")
        
    }
    
    func stopCarShakeAnimation () {
        self.carImageView.layer.removeAnimation(forKey: "carAnimation")
    }
}
