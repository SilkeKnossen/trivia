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
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        HighscoresController.shared.fetchHighscores { (highscores) in
            if let highScores = highscores {
                print("HALLO")
                self.highscoresList = highScores
                print("INFUNC \(self.highscoresList)")
            }
        }
        print("OUTFUNC \(self.highscoresList)")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("OUTFUNC \(self.highscoresList)")
        return self.highscoresList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        cell.textLabel?.text = self.highscoresList[indexPath.row].name
        cell.detailTextLabel?.text = self.highscoresList[indexPath.row].score
        return cell
    }

}
