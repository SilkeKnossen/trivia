//
//  QuestionsViewController.swift
//  trivia
//
//  Created by Silke Knossen on 09/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {

    // Create all outlets.
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    // Initialize an array of questions.
    var questions = [Question]()
    
    // Initialize current question.
    var questionIndex = 0
    
    // Initialize array of chosen answers.
    var answersChosen: [String] = []
    
    // When the view did load, fetch the questions and store them, then update the UI.
    override func viewDidLoad() {
        super.viewDidLoad()
        TriviaController.shared.fetchTriviaData { (questions) in
            if let questionsData = questions {
                self.questions = questionsData
                self.updateUI()
            }
        }
    }
    
    // Update the outlets in the view with question details.
    func updateUI() {
        DispatchQueue.main.async {
            let currentQuestion = self.questions[self.questionIndex]
            let currentAnswers = currentQuestion.allAnswers
            let totalProgress = Float(self.questionIndex) / Float(self.questions.count)
            
            self.answerButton1.setTitle(currentAnswers[0], for: .normal)
            self.answerButton2.setTitle(currentAnswers[1], for: .normal)
            self.answerButton3.setTitle(currentAnswers[2], for: .normal)
            self.answerButton4.setTitle(currentAnswers[3], for: .normal)
            
            self.navigationItem.title = "Question #\(self.questionIndex+1)"
            self.questionLabel.text = currentQuestion.question
            self.progressView.setProgress(totalProgress, animated: true)
        }
    }
    
    // Go to next question if there is one, otherwise go to the result view.
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultSegue", sender: nil)
        }
    }
    
    // If an answer button is pressed, append the answer to the player's chosen answers array.
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].allAnswers
        
        switch sender {
        case answerButton1:
            answersChosen.append(currentAnswers[0])
        case answerButton2:
            answersChosen.append(currentAnswers[1])
        case answerButton3:
            answersChosen.append(currentAnswers[2])
        case answerButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    // Give the questions and answers chosen to the result view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultSegue" {
            let resultTableViewController = segue.destination as! ResultTableViewController
            resultTableViewController.questions = questions
            resultTableViewController.answersChosen = self.answersChosen
        }
    }
}
