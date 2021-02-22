//
//  HomeViewController.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 01.07.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: BaseViewController {
var presenter: HomePresenter!
    override func awakeFromNib() {
          super.awakeFromNib()
          HomePresenter.config(withHomeViewController: self)
      }
      
    @IBAction func onBackButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: {
                
              })
    }
    
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if "jumpToLobby" == segue.identifier {
         if let vc = segue.destination as? LobbyController, let playerType = sender as? EnumPlayerType {
             vc.presenter.playerType = playerType
         }
     }
 }
    @IBAction func onHostButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "jumpToLobby", sender: EnumPlayerType.host)
    }
    @IBAction func onJoinButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "jumpToLobby", sender: EnumPlayerType.client)
    }
    
    override func viewDidLoad() {
          super.viewDidLoad()
       
      }
}
extension HomeViewController: HomeView {
    // TODO: implement view methods
}
