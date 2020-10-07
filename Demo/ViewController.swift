//
//  ViewController.swift
//  Demo
//
//  Created by Jawad Ali on 06/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import SpinnerAnimation
class ViewController: UIViewController {

    @IBAction func startAnimation(_ sender: Any) {
          progessView.addAndStartAnimation(in: self.view)
    }
    @IBAction func stopAnimation(_ sender: Any) {
         progessView.stopAnimating()
    }
    private lazy var progessView: SpinnerAnimation = {
        let progress = SpinnerAnimation()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        progessView.addAndStartAnimation(in: self.view)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        progessView.stopAnimating()
    }

}

