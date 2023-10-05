//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stopTimerButton: UIButton!
    let eggsTimeDict: [String : Int] = [
        "Soft" : 300,
        "Medium" : 480,
        "Hard" : 720
    ]
    var secondsRemaining = 10
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        stopTimerButton.isHidden = true
    }
    // some mark
    @IBAction func hardnessSelected(_ sender: UIButton) {
        // When we again press the button -> timer must be invalidate to start new timer
        timer.invalidate()
        titleLabel.text = "Timer started!"
        stopTimerButton.isHidden = false
        
        guard let title = sender.currentTitle else { return }
        print(title)
//        secondsRemaining = eggsTimeDict[title]!
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                return
            }
            if secondsRemaining > 0 {
                print("\(secondsRemaining) sec")
                secondsRemaining -= 1
            }
            
            if secondsRemaining == 0 {
                timer.invalidate()
                titleLabel.text = "Done!"
                titleLabel.textColor = UIColor(named: "GreenColor")
                print("Timer is invalidated")
            }
        }
    }
    
    @IBAction func stopTheTimer(_ sender: UIButton) {
        timer.invalidate()
        stopTimerButton.isHidden = true
    }
}
