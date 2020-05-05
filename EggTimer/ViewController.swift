//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var countdownLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.isHidden = true
        countdownLabel.isHidden = true
    }
    
   let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    

@IBAction func hardnessSelected(_ sender: UIButton) {
    
    progressView.isHidden = false
    countdownLabel.isHidden = false
    progressView.progress = 0
    secondsPassed = 0
    timer.invalidate()
    let hardness = sender.currentTitle!
    
    totalTime = eggTimes[hardness]! * 60
    titleLabel.text = hardness
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
    }
    
    @objc func updateTimer() {

        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressView.progress = percentageProgress
            countdownLabel.text = timeFormatted(totalTime - secondsPassed)
        } else {
            timer.invalidate()
            countdownLabel.text = "Done!"
            playSound()
        }
    }
    
    func timeFormatted(_ secondsRemaining: Int) -> String {
    let seconds: Int = secondsRemaining % 60
    let minutes: Int = (secondsRemaining / 60) % 60
    return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
