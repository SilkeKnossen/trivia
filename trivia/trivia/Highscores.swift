//
//  Highscores.swift
//  trivia
//
//  Created by Silke Knossen on 09/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import Foundation

struct highscore: Codable {
//    var id: Int
    var name: String
    var score: String
    
    init?(json: [String: Any]) {
//        print(json)
        guard let name = json["name"] as? String,
            let score = json["score"] as? String else { return nil }

//        self.id = id
        self.name = name
        self.score = score
    }
}
