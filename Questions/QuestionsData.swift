//
//  QuestionsData.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 06.08.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//


import Foundation
import FirebaseDatabase
class QuestionsData{
    
    static let sharedInstance = QuestionsData()
    
    //Data aus Firebase wird genommen
    func callFirebaseToFetchNewData(completion: @escaping () -> Void){
        
        Database.database().reference().child("child").observe(.value, with: {(snapshot)
            in
            var questions = [QuestionJSON]()
            
            if(QuestionsDataSingleton.sharedInstance.sharedQuestions.count == 0){
                for q in snapshot.children.allObjects as![DataSnapshot]{
                    
                    let questionObject = q.value as? [String:AnyObject]
                    let category =  questionObject?["category"]
                    let type = questionObject?["type"]
                    let difficulty = questionObject?["difficulty"]
                    let question = questionObject?["question"]
                    let correct_answer = questionObject?["correct_answer"]
                    let incorrect_answers = questionObject?["incorrect_answers"]
                    
                    let que = QuestionJSON(category: category as! String, type: type as! String, difficulty: difficulty as! String, question: question as! String, correct_answer: correct_answer as! String, incorrect_answers: incorrect_answers as! [String])
                    //Data in goods Array packen um es später in GoodsViewController zu nutzen
                    
                    questions.append(que)
                    
                    QuestionsDataSingleton.sharedInstance.sharedQuestions = questions.map(QuestionPresenter.present)
                }
            }
            completion()
        })}
    
    init() {
    }
    
    
    
    
    
    
   
    
    
    
    
}
