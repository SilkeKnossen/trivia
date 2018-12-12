//
//  HighscoresController.swift
//  trivia
//
//  Created by Silke Knossen on 10/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import Foundation

class HighscoresController {
    
    static let shared = HighscoresController()
    let url = URL(string: "https://ide50-silkeknossen.cs50.io:8080/list")!
//    var request = URLRequest(url: shared.url)
    
//    func fetchHighscores() -> Void {
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            let decoder = JSONDecoder()
//            if let data = data,
//                let json = try? decoder.decode([[String: String]].self, from: data) {
//                print(json)
//            } else {
//                print("nothing")
//            }
//        }
//        task.resume()
//    }
    
    func fetchHighscores(completion: @escaping ([highscore]?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let rawJSON = try? JSONSerialization.jsonObject(with: data),
                let json = rawJSON as? [[String: Any]] {
                    let highscores = json.map { highscore(json: $0) }
                    completion((highscores as! [highscore]))
                    print(highscores)
            } else {
                print("Either no data was returned, or data was not serialized.")
                completion(nil)
                return
            }
        }
        task.resume()
    }
    
    func addHighscore(name: String, score: String) -> Void {
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "name=\(name)&score=\(score)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
//                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(response)")
            }
        }
        task.resume()
    }
}
