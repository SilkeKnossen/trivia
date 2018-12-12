//
//  TriviaController.swift
//  trivia
//
//  Created by Silke Knossen on 08/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import Foundation

class TriviaController {
    
    let url = URL(string: "https://opentdb.com/api.php?amount=10&difficulty=easy&type=multiple")!
    static let shared = TriviaController()
    
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
