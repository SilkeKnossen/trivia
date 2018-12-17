//
//  TriviaController.swift
//  trivia
//
//  Created by Silke Knossen on 08/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import Foundation

/* This is the controller to communicate with the Trivia API.
 * It fetches the questions for the game.
 */
class TriviaController {
    
    // Create an URL to fetch data from.
    let url = URL(string: "https://opentdb.com/api.php?amount=10&difficulty=easy&type=multiple")!
    
    // Make this controller static.
    static let shared = TriviaController()
    
    // Fetch questions, decode them and store the data into the Question struct.
    func fetchTriviaData(completion: @escaping ([Question]?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let rawJSON = try? JSONSerialization.jsonObject(with: data),
                let json = rawJSON as? [String: Any],
                let resultsArray = json["results"] as? [[String: Any]] {
                    let questions = resultsArray.map { Question(json: $0) }
                    completion((questions as! [Question]))
            } else {
                print("Either no data was returned, or data was not serialized.")
                completion(nil)
                return
            }
        }
        task.resume()
    }
    
}
