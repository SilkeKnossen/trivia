//
//  Questions.swift
//  trivia
//
//  Created by Silke Knossen on 08/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import Foundation
import HTMLString

/*
 * Struct of a question, used to store the data fetched from the Trivia API.
 */
struct Question {
    var category: String
    var type: String
    var difficulty: String
    var question: String
    var correctAnswer: String
    var allAnswers: [String]
    
    init?(json: [String: Any]) {
        
        guard let category = json["category"] as? String,
            let type = json["type"] as? String,
            let difficulty = json["difficulty"] as? String,
            let question = json["question"] as? String,
            let correctAnswer = json["correct_answer"] as? String,
            let allAnswers = json["incorrect_answers"] as? [String] else { return nil }
        
        self.category = category
        self.type = type
        self.difficulty = difficulty
        self.question = question.removingHTMLEntities
        self.correctAnswer = correctAnswer.removingHTMLEntities
        self.allAnswers = allAnswers
        
        // Generate random iteger and append the correct answer to the list of all answers.
        let index = Int.random(in: 0 ... 3)
        self.allAnswers.insert(self.correctAnswer, at: index)
        
        // Remove HTML entities in all answers.
        let lastIndex = self.allAnswers.count - 1
        for i in 0...lastIndex {
            self.allAnswers[i] = self.allAnswers[i].removingHTMLEntities
        }
        
    }
}
