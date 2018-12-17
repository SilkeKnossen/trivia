//
//  ResultTableViewController.swift
//  trivia
//
//  Created by Silke Knossen on 10/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {

    // Initialize an array of questions.
    var questions = [Question]()
    
    // Initialize an array with chosen answers.
    var answersChosen = [String]()
    
    // Initialize score set to 0.
    var score = 0
    
    // Initialize list of scores.
    var scoreList: [String] = []
    
    // Initialize name of current player.
    var name: String = ""
    
    // When the view did load, get the score of current game.
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        getScore()
    }
    
    // Number of rows is the number of questions in the game plus a score cell.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count + 1
    }
    
    // Create the first table cell to show the scored points of the player.
    // Create each next cell with the question number, correct answer, and an icon that
    // indicates wheter the player's chosen answer is correct or not.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerTableViewCell", for: indexPath) as! AnswerTableViewCell
        if indexPath.row == 0 {
            cell.questionLabel.text = ""
            if self.score == 1 {
                cell.answerLabel.text = "Score: \(self.score) answer correct"
            } else {
                cell.answerLabel.text = "Score: \(self.score) answers correct"
            }
            cell.answerLabel.textColor = UIColor.white
            cell.scoreLabel.text = ""
            cell.backgroundColor = UIColor.red
        } else {
            cell.questionLabel.text = "Correct answer question \(indexPath.row)"
            cell.answerLabel.text = questions[indexPath.row - 1].correctAnswer
            cell.scoreLabel.text = self.scoreList[indexPath.row - 1]
            cell.backgroundColor = UIColor.white
            cell.answerLabel.textColor = UIColor.black
        }
        return cell
    }
    
    // Set height for each row to 65.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    // Compute score based on chosen answers, append an icon to the score list corresponding
    // to each chosen answer.
    func getScore() {
        let numQuestions = questions.count - 1
        for question in 0...numQuestions {
            if answersChosen[question] == questions[question].correctAnswer {
                self.score += 1
                scoreList.append("✔︎")
            } else {
                scoreList.append("✘")
            }
        }
    }
    
    // Perform segue to the highscores view.
    func uploadHighscore() {
        DispatchQueue.main.async {self.performSegue(withIdentifier: "PostScoreSegue", sender: nil)}
    }
    
    // When the post score button is tapped, show a pop up with a request to the player
    // to enter his/her name. This pop up can be confirmed or canceled.
    @IBAction func postScoreTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Confirm score upload", message: "You are about to upload your score of (\(self.score)) points. To upload your score, please fill in your name. You will not be able to return to this screen.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Upload", style: .default, handler: { action in
            let enteredName = alert.textFields![0]
            self.name = enteredName.text!
            self.uploadHighscore()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField { (textField) in textField.placeholder = "Enter name" }
        self.present(alert, animated: true, completion: nil)
    }
    
    // Give the player's name and score to the highscores view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PostScoreSegue" {
            let highscoresTableViewController = segue.destination as! HighscoresTableViewController
            highscoresTableViewController.name = self.name
            highscoresTableViewController.score = self.score
        }
    }
}
