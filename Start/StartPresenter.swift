//
//  StartPresenter.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 10.07.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation


protocol StartViewPresenter: class {
    init(view: StartView)
    func startHost(withPlayerName playerName: String)
    
    func getAvaiblePlayer() -> [Player]
    func getAvaiblePlayerNumber() -> Int
    func getAvaiblePlayer(withIndex index: Int) -> Player?
    func invitePlayerToMatchMaking(withOpponentPlayer opponentPlayer: Player)
    func isPlayerExists() -> Bool
}

protocol StartView: class {
    func showLoading(withTitle title: String?)
    func stopLoading()
}

class StartPresenter: StartViewPresenter {
    
    static func config(withStartViewController viewController: StartViewController) {
        let presenter = StartPresenter(view: viewController)
        viewController.presenter = presenter
    }
    
    let view: StartView
    
    var gameService: GameService!
    var avaiblePlayer = [Player]()
    var filteredQuestions : [QuestionViewModel] = []
    required init(view: StartView) {
        self.view = view
    }
    
    func setFilteredQuestions(filteredQuestions: [QuestionViewModel]){
        self.filteredQuestions = filteredQuestions
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
    
    func startHost(withPlayerName name: String) {
        saveFilteredQuestions(withFilteredQuestions: self.filteredQuestions)
        savePlayer(withPlayerName: name)
        
        
        
        let deadlineTime = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.gameService = GameService()
            self.gameService.startHost()
        }
    }
    
    
    
    func invitePlayerToMatchMaking(withOpponentPlayer opponentPlayer: Player) {
        guard let peerId = opponentPlayer.peerId else {
            // TODO: error Invite
            return
        }
        
        view.showLoading(withTitle: "Connecting...")
        gameService.invitePlayer(withPeerId: peerId)
    }
    
    
    func saveFilteredQuestions(withFilteredQuestions filteredQuestions: [QuestionViewModel]) {
        
        self.gameService = GameService()
        self.gameService.sendQuestions(questions: filteredQuestions)
        self.gameService.setQuestions(questions: filteredQuestions)
        
    }
    
    func savePlayer(withPlayerName playerName: String) {
        UserDefaults.standard.set(playerName, forKey: "playerInfo")
        UserDefaults.standard.synchronize()
    }
    
    func isPlayerExists() -> Bool {
        guard let savedPlayer = UserDefaults.standard.object(forKey: "playerInfo") as? String else {
            return false
        }
        
        return !savedPlayer.isEmpty
    }
}
