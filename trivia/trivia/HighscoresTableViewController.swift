//
//  HighscoresTableViewController.swift
//  trivia
//
//  Created by Silke Knossen on 10/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import UIKit

class HighscoresTableViewController: UITableViewController {

    var highscoresList = [highscore]()
    var name = String()
    var score = Int()
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
//        HighscoresController.shared.fetchHighscores { (highscores) in
//            if let highScores = highscores {
//                self.highscoresList = highScores
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
        HighscoresController.shared.addHighscore(name: self.name, score: String(self.score)) {
            HighscoresController.shared.fetchHighscores { (highscores) in
                if let highScores = highscores {
                    self.highscoresList = highScores
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.highscoresList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rankedHighscores = self.highscoresList.sorted { ($0.score > $1.score) }
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        cell.textLabel?.text = rankedHighscores[indexPath.row].name
        cell.detailTextLabel?.text = rankedHighscores[indexPath.row].score
        return cell
    }

}
