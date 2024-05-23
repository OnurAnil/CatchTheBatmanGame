//
//  ViewController.swift
//  CatchTheFevziGamee
//
//  Created by Onur Anıl on 5.03.2024.
//

import UIKit

class ViewController: UIViewController {
 //Variables
    
        var score = 0
        var timer = Timer()
        var counter = 0
        var fevziArray = [UIImageView]()
        var hideTimer = Timer()
        var highScore = 0
  //Views
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var fevzi1: UIImageView!
    @IBOutlet weak var fevzi2: UIImageView!
    @IBOutlet weak var fevzi3: UIImageView!
    @IBOutlet weak var fevzi4: UIImageView!
    @IBOutlet weak var fevzi5: UIImageView!
    @IBOutlet weak var fevzi6: UIImageView!
    @IBOutlet weak var fevzi7: UIImageView!
    @IBOutlet weak var fevzi8: UIImageView!
    @IBOutlet weak var fevzi9: UIImageView!
   
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            scoreLabel.text = "Score: \(score)"
            
            let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
            
            if storedHighScore == nil {
                highScore = 0;
                highscoreLabel.text = "highscore: \(highScore)"
            }
            if let newScore = storedHighScore as? Int {
                highScore = newScore
                highscoreLabel.text = "highscore: \(highScore)"
            }
            
            fevzi1.isUserInteractionEnabled = true
            fevzi2.isUserInteractionEnabled = true
            fevzi3.isUserInteractionEnabled = true
            fevzi4.isUserInteractionEnabled = true
            fevzi5.isUserInteractionEnabled = true
            fevzi6.isUserInteractionEnabled = true
            fevzi7.isUserInteractionEnabled = true
            fevzi8.isUserInteractionEnabled = true
            fevzi9.isUserInteractionEnabled = true
            
            let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            
            fevzi1.addGestureRecognizer(recognizer1)
            fevzi2.addGestureRecognizer(recognizer2)
            fevzi3.addGestureRecognizer(recognizer3)
            fevzi4.addGestureRecognizer(recognizer4)
            fevzi5.addGestureRecognizer(recognizer5)
            fevzi6.addGestureRecognizer(recognizer6)
            fevzi7.addGestureRecognizer(recognizer7)
            fevzi8.addGestureRecognizer(recognizer8)
            fevzi9.addGestureRecognizer(recognizer9)
            
            fevziArray = [fevzi1, fevzi2, fevzi3, fevzi4, fevzi5, fevzi6, fevzi7, fevzi8, fevzi9]
            
            counter = 0
            timeLabel.text = String(counter)
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
            
            hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideFevzi), userInfo: nil, repeats: true)
            
            hideFevzi()
            
        }
        
        @objc func hideFevzi() {
            for fevzi in fevziArray {
                fevzi.isHidden = true
            }
            
            let random = Int(arc4random_uniform(UInt32(fevziArray.count - 1)))
            fevziArray[random].isHidden = false
        }
        
        @objc func increaseScore(){
            score += 1
            scoreLabel.text = "Score: \(score)"
        }
        
        @objc func countDown(){
            counter += 1
            timeLabel.text = String(counter)
            
            if counter == 20 {
                timer.invalidate()
                hideTimer.invalidate()
                
                for fevzi in fevziArray{
                    fevzi.isHidden = true
                }
                // highScore
                if self.score > self.highScore {
                    self.highScore = self.score
                    highscoreLabel.text = "Highscore: \(self.highScore)"
                    UserDefaults.standard.set(self.highScore, forKey: "highscore")
                }
                
                let alert = UIAlertController(title: "Time`s Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
                let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                
                let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                    self.score = 0
                    self.scoreLabel.text = "Score \(self.score)"
                    self.counter = 0
                    self.timeLabel.text = String(self.counter)
                    
                    
                    
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                    self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideFevzi), userInfo: nil, repeats: true)
                }
                
                alert.addAction(okBtn)
                alert.addAction(replayButton)
                self.present(alert, animated: true, completion: nil)
                
                
            }
            
        }
        
        
    }

