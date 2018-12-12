//
//  ResultTableViewController.swift
//  trivia
//
//  Created by Silke Knossen on 10/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {

    var questions = [Question]()
    var answersChosen = [String]()
    var score = 0
    var scoreList: [String] = []
    var name: String = ""
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        getScore()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count + 1
    }
    
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
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
    
    func uploadHighscore(name: UITextField) {
        HighscoresController.shared.addHighscore(name: name.text!, score: String(self.score))
        performSegue()
    }
    
    func performSegue() {
        self.performSegue(withIdentifier: "PostScoreSegue", sender: nil)
    }
    
    @IBAction func postScoreTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Confirm score upload", message: "You are about to upload your score (\(self.score)). To upload your score, please fill in your name. You will not be able to return to this screen.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Upload", style: .default, handler: { action in
            let name = alert.textFields![0]
            self.uploadHighscore(name: name)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField { (textField) in textField.placeholder = "Enter name" }
        self.present(alert, animated: true, completion: nil)
    }
    
}
