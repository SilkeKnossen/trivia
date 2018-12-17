//
//  HighscoresTableViewController.swift
//  trivia
//
//  Created by Silke Knossen on 10/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import UIKit

class HighscoresTableViewController: UITableViewController {

    // Initialize list of highscores.
    var highscoresList = [highscore]()
    
    // Initialize the name and score of current player.
    var name = String()
    var score = Int()
    
    // When the view did load, start fetching highscores from the server.
    // When this is done, reload the view.
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        
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

    // If there are no scores loaded yet, return the number of cells is 1.
    // Otherwise, return number of highscores in the array.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.highscoresList.count
        if count == 0 {
            return 1
        } else {
            return count
        }
    }
    
    // Load scores in table view. If there are no scores yet, display loading screen.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.highscoresList.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
            cell.textLabel?.text = "Loading scores"
            cell.detailTextLabel?.text = ""
            return cell
        } else {
            let rankedHighscores = self.highscoresList.sorted { ($0.score > $1.score) }
            let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
            cell.textLabel?.text = rankedHighscores[indexPath.row].name
            cell.detailTextLabel?.text = rankedHighscores[indexPath.row].score
            return cell
        }
    }

}
