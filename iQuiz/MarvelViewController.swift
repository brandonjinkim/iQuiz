//
//  MarvelViewController.swift
//  iQuiz
//
//  Created by Brandon Kim on 5/10/25.
//

import UIKit

class MarvelViewController : UIViewController {
    var screenCount : Int = 1
    var userAnswer : String = ""
    var correctAnswer : String = ""
    var answerCount : Int = 0
    
    @IBOutlet weak var questionLabel : UILabel!
    @IBOutlet weak var answerLabel : UILabel!
    
    @IBOutlet weak var button1 : UIButton!
    @IBOutlet weak var button2 : UIButton!
    @IBOutlet weak var button3 : UIButton!
    
    @IBOutlet weak var submitButton : UIButton!
    
    @IBOutlet weak var swipe: UISwipeGestureRecognizer!
    @IBAction func swipeAction(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            performSegue(withIdentifier: "ViewController", sender: self)
        }
        else if sender.direction == .right {
            
        }
    }
    
    
    @objc func buttonPressed(_ sender: UIButton) {
        answerLabel.text = "You selected \(sender.currentTitle!)"
        userAnswer = sender.currentTitle!
    }
    
    @objc func submitPressed(_ sender: UIButton) {
        if userAnswer == "" {
            answerLabel.text = "Please select an answer!"
        }
        else if userAnswer == correctAnswer {
            answerCount += 1
            
            questionLabel.text = "Correct!"
            answerLabel.text = "\(String(answerCount))/\(String(screenCount))"
            
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = true
            
            submitButton.setTitle("Next", for: .normal)
            submitButton.removeTarget(self, action: nil, for: .allEvents)
            submitButton.addTarget(self, action: #selector(nextPressed(_:)), for: .touchUpInside)
        }
        else {
            questionLabel.text = "Incorrect. The correct answer was \(String(correctAnswer))"
            answerLabel.text = "\(String(answerCount))/\(String(screenCount))"
            
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = true
            
            submitButton.setTitle("Next", for: .normal)
            submitButton.removeTarget(self, action: nil, for: .allEvents)
            submitButton.addTarget(self, action: #selector(nextPressed(_:)), for: .touchUpInside)
        }
    }
    
    @objc func nextPressed(_ sender: UIButton) {
        screenCount += 1
        viewDidLoad()
    }
    
    @objc func finishedQuiz(_ sender: UIButton) {
        performSegue(withIdentifier: "ViewController", sender: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if screenCount == 1 {
            questionLabel.text = "What is Thor's Hammer's Name?"
            correctAnswer = "Mjolnir"
            
            button1.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button1.setTitle("Stormbreaker", for: .normal)
            
            button2.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button2.setTitle("Mjolnir", for: .normal)
            
            button3.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button3.setTitle("Jonathan", for: .normal)
            
            submitButton.addTarget(self, action: #selector(submitPressed(_:)), for: .touchUpInside)
            submitButton.setTitle("Submit", for: .normal)
            
        }
        
        else if screenCount == 2 {
            questionLabel.text = "Who is Iron Man?"
            answerLabel.text = ""
            correctAnswer = "Tony Stark"
            
            button1.isHidden = false
            button1.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button1.setTitle("Tony Stark", for: .normal)
            
            button2.isHidden = false
            button2.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button2.setTitle("Steve Rogers", for: .normal)
            
            button3.isHidden = false
            button3.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button3.setTitle("Rhodey", for: .normal)
            
            submitButton.removeTarget(self, action: nil, for: .allEvents)
            submitButton.addTarget(self, action: #selector(submitPressed(_:)), for: .touchUpInside)
            submitButton.setTitle("Submit", for: .normal)
            
        }
        
        else if screenCount == 3 {
            questionLabel.text = "What color is the Time Stone?"
            answerLabel.text = ""
            correctAnswer = "Green"
            
            button1.isHidden = false
            button1.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button1.setTitle("Purple", for: .normal)
            
            button2.isHidden = false
            button2.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button2.setTitle("Green", for: .normal)
            
            button3.isHidden = false
            button3.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button3.setTitle("Pink", for: .normal)
            
            submitButton.removeTarget(self, action: nil, for: .allEvents)
            submitButton.addTarget(self, action: #selector(submitPressed(_:)), for: .touchUpInside)
            submitButton.setTitle("Submit", for: .normal)
            
        }
        
        else {
            if answerCount == 3 {
                questionLabel.text = "Perfect Score! You are a real Marvel Fan!"
            }
            else if answerCount == 2 {
                questionLabel.text = "Almost!"
            }
            else if answerCount == 1 {
                questionLabel.text = "Keep trying!"
            }
            else {
                questionLabel.text = "And you call yourself a Marvel fan?"
            }
            submitButton.removeTarget(self, action: nil, for: .allEvents)
            submitButton.addTarget(self, action: #selector(finishedQuiz(_:)), for: .touchUpInside)
        }
    }
}
