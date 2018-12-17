//
//  HighscoresController.swift
//  trivia
//
//  Created by Silke Knossen on 10/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import Foundation

/* This controller communicates with the server where all highscores are stored.
 * It contains functions to upload or fetch highscores.
 */
class HighscoresController {
    
    // Make this controller static.
    static let shared = HighscoresController()
    
    // Create URL to send requests to.
    let url = URL(string: "https://ide50-silkeknossen.cs50.io:8080/list")!
    
    // Fetch the highscores data stored in the server, decode it and store it in an array
    // of highscores.
    func fetchHighscores(completion: @escaping ([highscore]?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let rawJSON = try? JSONSerialization.jsonObject(with: data),
                let json = rawJSON as? [[String: Any]] {
                    let highscores = json.map { highscore(json: $0) }
                    completion((highscores as! [highscore]))
            } else {
                print("Either no data was returned, or data was not serialized.")
                completion(nil)
                return
            }
        }
        task.resume()
    }
    
    // Upload an highscore with a name and score, decode it as a JSON object.
    func addHighscore(name: String, score: String, completion: @escaping () -> Void) {
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "name=\(name)&score=\(score)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion()

            guard let _ = data, error == nil else {
                return
            }
        }
        task.resume()
    }
}
