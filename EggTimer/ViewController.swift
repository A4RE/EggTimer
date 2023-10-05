//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // MARK: - PROPERTIES
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stopTimerButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    let eggsTimeDict: [String : Float] = [
        "Soft" : 10,
        "Medium" : 20,
        "Hard" : 30
    ]
    var player: AVAudioPlayer?
    var totalTime: Float = 0
    var secondsPassed: Float = 0
    var timer = Timer()

    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        stopTimerButton.isHidden = true
    }
    
    // MARK: - EGGS BUTTONS ACTION
    @IBAction func hardnessSelected(_ sender: UIButton) {
        // When we again press the button -> timer must be invalidate to start new timer
        
        secondsPassed = 0
        progressView.progressTintColor = UIColor(named: "YellowColor")
        timer.invalidate()
        titleLabel.text = "Timer started!"
        titleLabel.textColor = UIColor(named: "YellowColor")
        stopTimerButton.isHidden = false
        
        guard let title = sender.currentTitle else { return }
        
        totalTime = eggsTimeDict[title]!
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                return
            }
            if secondsPassed < totalTime {
                secondsPassed += 1
                let percentageProgress = secondsPassed / totalTime
                progressView.setProgress(percentageProgress, animated: true)
            } else {
                timer.invalidate()
                titleLabel.text = "Done!"
                titleLabel.textColor = UIColor(named: "GreenColor")
                playSound()
                print("Timer is invalidated")
            }
            if progressView.progress == 1 {
                progressView.progressTintColor = UIColor(named: "GreenColor")
            }
        }
    }
    // MARK: - STOP TIMER BUTTON
    @IBAction func stopTheTimer(_ sender: UIButton) {
        timer.invalidate()
        stopTimerButton.isHidden = true
        progressView.setProgress(0.0, animated: true)
        titleLabel.text = "How do you like your eggs?"
        titleLabel.textColor = .darkGray
    }
    // MARK: - PLAY SOUND FUNCTION
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType: "mp3") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
}
