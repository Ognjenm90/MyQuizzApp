//
//  ViewController.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 18.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//
import Foundation
import UIKit
import MultipeerConnectivity


class StartViewController: BaseViewController{
    
    var name:String = ""
    var gameType:String = "multiplayer"
    @IBOutlet var bitton: UIButton!
    
    
    var presenter: StartPresenter!
    var filteredQuestions: [QuestionViewModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        StartPresenter.config(withStartViewController: self)
    }
    
    //mit dem Klick darauf wird ein Spieler gesucht
    @IBAction func gettingStarted(_ sender: Any) {
        
        if (gameType == "singleplayer"){
    self.performSegue(withIdentifier: "jumpToQuiz", sender: nil)
        }else if(gameType == "multiplayer") {
        if  !name.isEmpty {
            
            bitton.isUserInteractionEnabled = false
            bitton.setImage(#imageLiteral(resourceName: "start-button-disable"), for: .normal)
            
            presenter.saveFilteredQuestions(withFilteredQuestions: self.filteredQuestions)
            presenter.setFilteredQuestions(filteredQuestions: self.filteredQuestions)
            presenter.startHost(withPlayerName: name)
            
            let deadlineTime = DispatchTime.now() + .milliseconds(500)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.presenter.gameService.delegate = self
            }
        } else
            {
        }
    }
}
    //die Fragen und Bescheid ob "multi-" oder "singleplayer" gespielt wird, werden zu Quiz übertragen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "jumpToQuiz"{
            let vc = segue.destination as! QuizViewController
            vc.name = name
            vc.gameType = gameType
            vc.filteredQuestions = filteredQuestions
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }}

extension StartViewController: StartView {
    func showLoading(withTitle title: String?) {
        showLoading(withView: self.view, andTitle: title)
    }
    func stopLoading() {
        hideLoading()
    }
}
extension StartViewController: GameServiceDelegate {
    
    func GameService(deviceConnectingWithManager manager: GameService, connectedDevices: String) {
        print("Connecting to Opponent Player")
    }
    
    func GameService(deviceConnectedWithManager manager: GameService, connectedDevices: String) {
        print("Connected to Opponent Player")
        self.presenter.gameService.stopHost()
        self.presenter.gameService.stopBrowse()
        self.presenter.gameService.sendQuestions(questions: self.filteredQuestions)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.performSegue(withIdentifier: "jumpToQuiz", sender: nil)
            }
        )
    }
    func GameService(deviceConnectingFailedWithManager manager: GameService, connectedDevices: String) {
        print("Failed Connect to Opponent Player")
    }
    
    func GameService(sendAvaiblePlayers avaiblePlayers: [Player]) {
        
        presenter.avaiblePlayer = avaiblePlayers
    }
}
extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getAvaiblePlayerNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "playerCell")
        
        if let player = presenter.getAvaiblePlayer(withIndex: indexPath.row) {
            print("Avaible: \(player.name)")
            cell.textLabel?.text = player.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let player = presenter.getAvaiblePlayer(withIndex: indexPath.row) else {
            print("Avaible Player Not Found")
            return
        }
        
        if  !name.isEmpty {
            presenter.invitePlayerToMatchMaking(withOpponentPlayer: player)
        } else {
            print("name is empty")
        }
    }
}


