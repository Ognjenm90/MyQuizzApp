//
//  QuestionsViewModel.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 30.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation



extension Equatable where Self: AnyObject{

   static func ==(lhs: Self, rhs: Self) -> Bool {
      return lhs === rhs
   }
}

class QuestionViewModel: NSObject, Codable {

    var category : String
    var type : String
      var questionText: String
      var options: [String]
      var incorrect_answer: Int!
      var correct_answer: Int!
      var isAnswered: Bool = false
      var difficulty: String
      var selected: Bool = false

    required init(coder aDecoder: NSCoder) {
        category = aDecoder.decodeObject(forKey: "category") as! String
        type = aDecoder.decodeObject(forKey: "type") as! String
        questionText = aDecoder.decodeObject(forKey: "questionText") as! String
        options = aDecoder.decodeObject(forKey: "options") as! [String]
        incorrect_answer = aDecoder.decodeObject(forKey: "incorrect_answer") as? Int
        correct_answer = (aDecoder.decodeObject(forKey: "correct_answer") as? Int)
        isAnswered = aDecoder.decodeBool(forKey: "isAnswered")
        difficulty = aDecoder.decodeObject(forKey: "difficulty") as! String
        selected = aDecoder.decodeBool(forKey: "selected")
    }

   


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

