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
}

class TableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel?
    @IBOutlet var subtitle: UILabel?
    @IBOutlet var picture: UIImageView?
}

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
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
    
    var itemList: [TableItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img1 = UIImage(named: "math")!
        let img2 = UIImage(named: "marvel")!
        let img3 = UIImage(named: "science")!
        
        itemList = [
            TableItem(title: "Mathematics", subtitle: "What's 9 + 10?", picture: img1),
            TableItem(title: "Marvel Super Heroes", subtitle: "Who's the strongest Avenger?", picture: img2),
            TableItem(title: "Science", subtitle: "Biology, Chemistry, Physics, oh my!", picture: img3)
        ]
        
        // prevents nil tableview from being loaded
        guard tableView != nil else {
            return
        }

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBOutlet weak var settingButton: UIButton!
    @IBAction func settingButton(_ sender: Any) {
        let alert = UIAlertController(title: "You selected", message: "settings", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Close the alert"), style: .default, handler: { _ in
            NSLog("User said cancel.")
            alert.dismiss(animated: true)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Close the alert"), style: .default, handler: { _ in
            NSLog("User said OK.")
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
}

