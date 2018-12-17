//
//  Highscores.swift
//  trivia
//
//  Created by Silke Knossen on 09/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import Foundation

/*
 * The struct to store a highscore with name and score of the player.
 */
struct highscore: Codable {
    var name: String
    var score: String
    
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
            let score = json["score"] as? String else { return nil }

        self.name = name
        self.score = score
    }
}
