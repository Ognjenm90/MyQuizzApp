//
//  QuestionsViewModel.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 30.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation
import os.log

class QuestionViewModel {

    var category : String
    var type : String
      var questionText: String
      var options: [String]
      var incorrect_answer: Int
      var correct_answer: Int
      var isAnswered: Bool = false
      var difficulty: String
      var selected: Bool = false



     init(category : String,
      type : String,
      questionText: String,
      options: [String],
      incorrect_answer: Int,
      correct_answer: Int,
      isAnswered: Bool,
      difficulty: String,
      selected: Bool) {
        
        self.category = category
        self.type = type
        self.options = options
        self.incorrect_answer = incorrect_answer
        self.correct_answer = correct_answer
        self.isAnswered = isAnswered
        self.difficulty = difficulty
        self.selected = selected
        self.questionText = questionText
     }
 
    


}

