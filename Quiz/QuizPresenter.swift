//
//  QuizPresenter.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 15.07.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation
protocol QuizViewPresenter: class {
    init(view: QuizView)
    
    // func sendScore()
    func setReceiveDeclarationVictory(_ victory: Bool)
    func getReceiveDeclarationVictory() -> Bool
}

protocol QuizView: class {
    func showLoading(withTitle title: String?)
    func stopLoading()
}

class QuizPresenter: QuizViewPresenter {
    
    static func config(withQuizViewController viewController: QuizViewController) {
        let presenter = QuizPresenter(view: viewController)
        viewController.presenter = presenter
        
    }
    
    let view: QuizView
    var playerType: EnumPlayerType = .host
    var gameService: GameService = GameService()
    var avaiblePlayer = [Player]()
    var filteredQuestions : [QuestionViewModel] = []
    var receiveDeclarationVictory: Bool = false
    var opponentScore: Int = 1
    
    required init(view: QuizView) {
        self.view = view
    }
    
   
    func waitAnotherPlayerLoading(){
        view.showLoading(withTitle: "Warte bis dein gegner fertig ist!")
    }
    
    func setFilteredQuestions(filteredQuestions: [QuestionViewModel]){
        self.filteredQuestions = filteredQuestions
    }
    
    func getPlayerType() -> EnumPlayerType {
        return playerType
    }
    
    func getAvaiblePlayer() -> [Player] {
        
        return avaiblePlayer
    }
    
    func getAvaiblePlayerNumber() -> Int {
        return avaiblePlayer.count
    }
    
    
    func getAvaiblePlayer(withIndex index: Int) -> Player? {
        if avaiblePlayer.indices.contains(index) {
            return avaiblePlayer[index]
        }
        return nil
    }
    
    func setReceiveDeclarationVictory(_ victory: Bool) {
        self.receiveDeclarationVictory = victory
    }
    
    func getReceiveDeclarationVictory() -> Bool {
        return receiveDeclarationVictory
    }
    
    
    func saveFilteredQuestions(withFilteredQuestions filteredQuestions: [QuestionViewModel]) {
        
        let codedData = NSKeyedArchiver.archivedData(withRootObject: filteredQuestions)
        UserDefaults.standard.set(codedData, forKey: "filteredQuestions")
        UserDefaults.standard.synchronize()
    }
    
    
    
    func isPlayerExists() -> Bool {
        guard let savedPlayer = UserDefaults.standard.object(forKey: "playerInfo") as? String else {
            return false
        }
        
        return !savedPlayer.isEmpty
    }
}
