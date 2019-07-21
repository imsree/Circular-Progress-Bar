//
//  CircularLoader.swift
//  Circular Progress Bar
//
//  Created by Sree .... on 20/07/19.
//  Copyright © 2019 Sree . All rights reserved.
//

import UIKit

class CircularLoader: UIView {
    
    let circleLayer = CAShapeLayer()
    let progressLayer = CAShapeLayer()
    
    let strokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        return animation
    }()
    
    let strokeStartAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.fromValue = 0
        animation.toValue = 1
        animation.beginTime = 0.5
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.isCumulative = true
        return animation
    }()
    
    let rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        let rotatingAngle: CGFloat = 2 * .pi
        animation.fromValue = 0
        animation.toValue = rotatingAngle
        // animation.duration = 2.5
        //  animation.isAdditive = true
        //   animation.repeatCount = MAXFLOAT
        return animation
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCircularRing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCircularRing() {
        circleLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        let startAngle: CGFloat = -.pi / 2
        let endAngle: CGFloat = 3 * .pi / 2
        
        let circlePath = UIBezierPath(arcCenter: .zero, radius: 80, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        circleLayer.path = circlePath.cgPath
        // circleLayer.lineWidth = 4 for groupAnimation
        circleLayer.lineWidth = 20
        circleLayer.fillColor = UIColor.clear.cgColor
        // circleLayer.strokeColor = UIColor.lightGray.cgColor for groupAnimation
        circleLayer.strokeColor = UIColor.black.cgColor
        
        progressLayer.path = circlePath.cgPath
        // progressLayer.lineWidth = 3 for groupAnimation
        progressLayer.lineWidth = 10
        progressLayer.fillColor = UIColor.clear.cgColor
        // progressLayer.strokeColor = UIColor.black.cgColor for groupAnimation
        progressLayer.strokeColor = UIColor.red.cgColor
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }
    
    func progressAnimation(duration: TimeInterval) {
        strokeEndAnimation.duration = duration
        progressLayer.add(strokeEndAnimation, forKey: "first")
    }
    
    func groupAnimation() {
        let group = CAAnimationGroup()
        group.animations = [strokeStartAnimation, strokeEndAnimation, rotationAnimation]
        group.duration = 2.5
        group.repeatCount = MAXFLOAT
        progressLayer.add(group, forKey: "grp")
    }
}

