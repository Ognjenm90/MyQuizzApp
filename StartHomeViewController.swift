//
//  StartHomeViewController.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 11.08.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation
import UIKit
//Hier wird ausgewählt ob man Multi- oder Singleplayer spielt
class StartHomeViewController : BaseViewController{

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
          if segue.identifier == "singlePlayerSeque"{
              let vc = segue.destination as! CategorieViewController
              vc.gameType = "singleplayer"
          }
      }
    override func awakeFromNib() {
           super.awakeFromNib()
          
       }
     override func viewDidLoad() {
           super.viewDidLoad()
       
       }
}

