//
//  ViewController.swift
//  Circular Progress Bar
//
//  Created by Sree .... on 20/07/19.
//  Copyright © 2019 Sree . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let circularBar = CircularLoader()
    let duration: Double = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        circularBar.center = view.center
        view.addSubview(circularBar)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewGotTapped)))
    }
    
    @objc func viewGotTapped() {
        circularBar.progressAnimation(duration: duration)
        
        // For groupAnimation
        // circularBar.groupAnimation()
    }
}

