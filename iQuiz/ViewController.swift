//
//  ViewController.swift
//  iQuiz
//
//  Created by Brandon Kim on 5/3/25.
//

import UIKit

struct TableItem {
    var title: String
    var subtitle: String
    var picture: UIImage
    var quiz: Quiz
}

struct Quiz: Codable {
    var title: String
    var desc: String
    var questions: [Question]
}

struct Question: Codable {
    var text: String
    var answer: String
    var answers: [String]
}

class TableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel?
    @IBOutlet var subtitle: UILabel?
    @IBOutlet var picture: UIImageView?
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var itemList: [TableItem] = []
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func loadQuizzes(from quizzes: [Quiz]) {
        self.itemList = quizzes.map {
            let image = getImage(for: $0.title)
            return TableItem(title: $0.title, subtitle: $0.desc, picture: image, quiz: $0)
        }
        self.tableView.reloadData()
    }

    func getImage(for title: String) -> UIImage {
        let lowercased = title.lowercased()
        if lowercased.contains("math") {
            return UIImage(named: "math")!
        } else if lowercased.contains("science") {
            return UIImage(named: "science")!
        } else if lowercased.contains("marvel") {
            return UIImage(named: "marvel")!
        } else {
            return UIImage(named: "default_quiz")!
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let item = itemList[indexPath.row]
        
        cell.title?.text = item.title
        cell.subtitle?.text = item.subtitle
        cell.picture?.image = item.picture
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 163
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "QuizSegue", sender: itemList[indexPath.row].quiz)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QuizSegue", let destination = segue.destination as? QuizViewController, let quiz = sender as? Quiz {
            destination.quiz = quiz
        }
    }

    @IBAction func unwindFromSettings(_ segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? SettingsViewController {
            let quizzes = sourceVC.quizzesToReturn
            self.loadQuizzes(from: quizzes)
        }
    }
}
