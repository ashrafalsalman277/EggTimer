

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player : AVAudioPlayer!
    
    @IBOutlet weak var percentageNumber: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes:[String:Int] = ["Soft":5,"Medium":20,"Hard":120]
    var timer = Timer()
    var totalTime = 0
    var seconedsPassed = 0
    
     @IBAction func hardnessSelected(_ sender: UIButton) {
         timer.invalidate()//Stops any running timer to prevent multiple timers running at the same time.
        let  hardness = sender.currentTitle!// Soft Medium Hard
         
         progressBar.progress = 0.0
         seconedsPassed = 0
         titleLabel.text = hardness
         titleLabel.textColor = .white
         
         
        totalTime = eggTimes[hardness]!
        timer=Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
         
        }
    func playSound(soundName:String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    @objc func updateTimer(){
        if seconedsPassed < totalTime{
            seconedsPassed+=1
            let perctengeProggress = Float(seconedsPassed) / Float(totalTime)
            progressBar.progress = perctengeProggress
            percentageNumber.text = String(format: "%.0f%%", perctengeProggress * 100)
        }
        else{
            timer.invalidate()
            titleLabel.text = "Done!!!!!!!"
            titleLabel.textColor = .red
            playSound(soundName:"alarm_sound")
            timer=Timer.scheduledTimer(timeInterval:Double(seconedsPassed) + 2.0, target: self, selector: #selector(reset), userInfo: nil, repeats: true)
        }
    }
    @objc func reset(){
        titleLabel.text = " What do you like your eggs ?"
        titleLabel.textColor = .white
    }
}



