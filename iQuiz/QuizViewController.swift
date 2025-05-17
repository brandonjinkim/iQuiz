//
//  QuizViewController.swift
//  iQuiz
//
//  Created by Brandon Kim on 5/12/25.
//

import UIKit

class QuizViewController: UIViewController {

    var quiz: Quiz?
    
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    var currentQuestionIndex: Int = 0
    var correctAnswerCount: Int = 0

    var userAnswer: Int? = nil

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!

    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        button1.tag = 0
        button2.tag = 1
        button3.tag = 2
        button4.tag = 3

        button1.addTarget(self, action: #selector(answerSelected(_:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(answerSelected(_:)), for: .touchUpInside)
        button3.addTarget(self, action: #selector(answerSelected(_:)), for: .touchUpInside)
        button4.addTarget(self, action: #selector(answerSelected(_:)), for: .touchUpInside)

        submitButton.addTarget(self, action: #selector(submitPressed(_:)), for: .touchUpInside)

        loadCurrentQuestion()
    }

    func loadCurrentQuestion() {
        userAnswer = nil
        answerLabel.text = ""

        hideAnswerButtons(false)
        submitButton.setTitle("Submit", for: .normal)
        
        guard let quiz = quiz else {
            return
        }
        
        let question = quiz.questions[currentQuestionIndex]
        questionLabel.text = question.text

        let answers = question.answers
        button1.setTitle(answers.count > 0 ? answers[0] : "", for: .normal)
        button2.setTitle(answers.count > 1 ? answers[1] : "", for: .normal)
        button3.setTitle(answers.count > 2 ? answers[2] : "", for: .normal)
        button4.setTitle(answers.count > 3 ? answers[3] : "", for: .normal)

        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
    }

    func hideAnswerButtons(_ hide: Bool) {
        button1.isHidden = hide
        button2.isHidden = hide
        button3.isHidden = hide
        button4.isHidden = hide
    }

    @objc func answerSelected(_ sender: UIButton) {
        userAnswer = sender.tag
        answerLabel.text = "You selected: \(sender.currentTitle ?? "")"
        
        submitButton.removeTarget(nil, action: nil, for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitPressed(_:)), for: .touchUpInside)
        
        resetButtonColors()
        sender.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.5)
    }

    func resetButtonColors() {
        [button1, button2, button3, button4].forEach { button in
            button?.backgroundColor = .clear
        }
    }

    @objc func submitPressed(_ sender: UIButton) {
        guard let selected = userAnswer else {
            answerLabel.text = "Please select an answer!"
            return
        }

        guard let quiz = quiz else { return }
        let question = quiz.questions[currentQuestionIndex]

        if selected + 1 == Int(question.answer) {
            correctAnswerCount += 1
            answerLabel.text = "Correct!"
        } else {
            answerLabel.text = "Incorrect! Correct answer: \(question.answers[Int(question.answer)! - 1])"
        }

        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        
        submitButton.setTitle("Next", for: .normal)
        submitButton.removeTarget(self, action: #selector(submitPressed(_:)), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(nextPressed(_:)), for: .touchUpInside)
        
//        if currentQuestionIndex + 1 < quiz.questions.count {
//            submitButton.setTitle("Next", for: .normal)
//            submitButton.removeTarget(self, action: #selector(submitPressed(_:)), for: .touchUpInside)
//            submitButton.addTarget(self, action: #selector(nextPressed(_:)), for: .touchUpInside)
//        } else {
//            submitButton.setTitle("Finish", for: .normal)
//            submitButton.removeTarget(self, action: #selector(submitPressed(_:)), for: .touchUpInside)
////            submitButton.addTarget(self, action: #selector(finishQuiz(_:)), for: .touchUpInside)
//        }
    }

    @objc func nextPressed(_ sender: UIButton) {
        currentQuestionIndex += 1
        resetButtonColors()
        guard let quiz = quiz, currentQuestionIndex < quiz.questions.count else {
            questionLabel.text = "Quiz Complete! You scored \(correctAnswerCount)/\(quiz?.questions.count ?? 0)."
            if correctAnswerCount % Int(quiz?.questions.count ?? 0) == 0 && correctAnswerCount != 0 {
                answerLabel.text = "Perfect!"
            }
            else {
                answerLabel.text = "Next time!"
            }
            hideAnswerButtons(true)
            submitButton.setTitle("Finish", for: .normal)
            submitButton.removeTarget(self, action: #selector(submitPressed(_:)), for: .touchUpInside)
            submitButton.addTarget(self, action: #selector(finishQuiz(_:)), for: .touchUpInside)
            return
        }
        loadCurrentQuestion()
    }

    @objc func finishQuiz(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
