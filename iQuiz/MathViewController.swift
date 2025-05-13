//
//  MathViewController.swift
//  iQuiz
//
//  Created by Brandon Kim on 5/9/25.
//

import UIKit

class MathViewController : UIViewController {
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
            questionLabel.text = "What is the square root of 144?"
            correctAnswer = "12"
            
            button1.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button1.setTitle("14", for: .normal)
            
            button2.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button2.setTitle("13", for: .normal)
            
            button3.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button3.setTitle("12", for: .normal)
            
            submitButton.addTarget(self, action: #selector(submitPressed(_:)), for: .touchUpInside)
            submitButton.setTitle("Submit", for: .normal)
            
        }
        
        else if screenCount == 2 {
            questionLabel.text = "What is 5 + 5?"
            answerLabel.text = ""
            correctAnswer = "10"
            
            button1.isHidden = false
            button1.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button1.setTitle("10", for: .normal)
            
            button2.isHidden = false
            button2.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button2.setTitle("0", for: .normal)
            
            button3.isHidden = false
            button3.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button3.setTitle("2", for: .normal)
            
            submitButton.removeTarget(self, action: nil, for: .allEvents)
            submitButton.addTarget(self, action: #selector(submitPressed(_:)), for: .touchUpInside)
            submitButton.setTitle("Submit", for: .normal)
            
        }
        
        else if screenCount == 3 {
            questionLabel.text = "How many sides does a octagon have?"
            answerLabel.text = ""
            correctAnswer = "8"
            
            button1.isHidden = false
            button1.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button1.setTitle("6", for: .normal)
            
            button2.isHidden = false
            button2.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button2.setTitle("8", for: .normal)
            
            button3.isHidden = false
            button3.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button3.setTitle("10", for: .normal)
            
            submitButton.removeTarget(self, action: nil, for: .allEvents)
            submitButton.addTarget(self, action: #selector(submitPressed(_:)), for: .touchUpInside)
            submitButton.setTitle("Submit", for: .normal)
            
        }
        
        else {
            if answerCount == 3 {
                questionLabel.text = "Perfect Score! Great job."
            }
            else if answerCount == 2 {
                questionLabel.text = "Almost there!"
            }
            else if answerCount == 1 {
                questionLabel.text = "Keep trying!"
            }
            else {
                questionLabel.text = "Did you graduate elementary school?"
            }
            submitButton.removeTarget(self, action: nil, for: .allEvents)
            submitButton.addTarget(self, action: #selector(finishedQuiz(_:)), for: .touchUpInside)
        }
    }
}
