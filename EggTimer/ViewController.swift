//
//  ViewController.swift
//  EggTimer
//


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft"  : 3, "Medium" :  420, "Hard"  : 720 ]  //in seconds
    var timer = Timer()
    var totalTime = 0
    var secPassed = 0
    
    var alarmSoundEffect: AVAudioPlayer?
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate() //stop the old timer when a button is pressed
        
        let hardness = sender.currentTitle!  //soft, medium, hard
        totalTime =  eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        //timeInterval: how often do you want to fire the timer (every sec). selector: calls the func
    }
    
    @objc func updateTimer()  { //selector is from objective-c hence we need @objc
        if secPassed < totalTime {
            
            secPassed += 1
            progressBar.progress = Float(secPassed) / Float(totalTime)
        
        } else {
            do {
                
                timer.invalidate()
                titleLabel.text = "Done"
                
                let path = Bundle.main.path(forResource: "alarm_sound.mp3", ofType:nil)!
                let url = URL(fileURLWithPath: path)
                
                alarmSoundEffect = try AVAudioPlayer(contentsOf: url)
                alarmSoundEffect?.play()
                
            } catch {
                // couldn't load file :(
            }
        }
    }
}
