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
    
    var eggTimes = ["soft": 300, "medium": 420, "hard": 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eggProgressBar: UIProgressView!
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eggProgressBar.progress = 0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate() // Reset timer
        let hardness = sender.currentTitle! // Soft, Medium, Hard
        totalTime = eggTimes[hardness]! // Time for each type of egg
        eggProgressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = "Cooking a \(hardness) egg..."
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            if secondsPassed < totalTime {
                secondsPassed += 1
                eggProgressBar.progress = Float(secondsPassed) / Float(totalTime)
            } else {
                Timer.invalidate()
                self.titleLabel.text = "DONE!"
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }
        }
    }
}
