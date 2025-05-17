//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Brandon Kim on 5/14/25.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    var quizzesToReturn: [Quiz] = []

    @IBAction func checkNowPressed(_ sender: Any) {
        guard let urlString = textField.text, let url = URL(string: urlString) else {
            showErrorAlert(message: "Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    return
                }

                guard let data = data else {
                    print(error)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let quizzes = try decoder.decode([Quiz].self, from: data)
                    self.quizzesToReturn = quizzes

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if self.view.window != nil {
                            self.performSegue(withIdentifier: "ReturnToQuizList", sender: self)
                        } else {
                            print("didnt work")
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }


    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
