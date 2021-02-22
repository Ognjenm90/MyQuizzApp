//
//  QuestionJSON.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 24.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation

struct QuestionJSON: Codable  {
    var category: String;
    var type: String;
    var difficulty: String;
    var question: String;
    var correct_answer: String
    var incorrect_answers: [String]
    
}

