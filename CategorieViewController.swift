//
//  CategorieViewController.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 28.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation
import UIKit
class CategorieViewController: UIViewController {
    
    
    @IBOutlet var categoryView1: UIView!
    @IBOutlet var categoryView2: UIView!
    @IBOutlet var categoryView3: UIView!
    @IBOutlet var categoryView4: UIView!
    @IBOutlet var categoryView5: UIView!
    @IBOutlet var categoryView6: UIView!
    @IBOutlet var categoryView7: UIView!
    @IBOutlet var categoryView8: UIView!
    @IBOutlet var categoryView9: UIView!
    @IBOutlet var categoryView10: UIView!
    @IBOutlet var categoryView11: UIView!
    @IBOutlet var categoryView12: UIView!
    @IBOutlet var categoryView13: UIView!
    @IBOutlet var categoryView14: UIView!
    @IBOutlet var categoryView15: UIView!
    @IBOutlet var categoryView16: UIView!
    @IBOutlet var categoryView17: UIView!
    @IBOutlet var categoryView18: UIView!
    @IBOutlet var categoryView19: UIView!
    @IBOutlet var categoryView20: UIView!
    @IBOutlet var categoryView21: UIView!
    @IBOutlet var categoryView22: UIView!
    @IBOutlet var categoryView23: UIView!
    @IBOutlet var categoryView24: UIView!
    
    var name: String = ""
    fileprivate let navigationCtrl = UINavigationController()
    var filteredQuestions : [QuestionViewModel] = []
    var gameType: String = ""
    var categoryArray:[String] = []
  
    //Die fragen werden aus DB genommen und erst danach wird das View Geladen
    func getDataFromFirebase(){
          QuestionsData.sharedInstance.callFirebaseToFetchNewData(){
                         super.viewDidLoad() }
      }
   
    func getDataFromJSONFile(){
                 //die Fragen werden aus JSON datei genommen
          if let path = Bundle.main.path(forResource: "questions", ofType: "json") {
              do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let decoder = JSONDecoder()
                  do {
                      // get the data from JSON file with help of struct and Codable
                      let questionJSON = try decoder.decode([QuestionJSON].self, from: data)
                      // from here you can populate data in tableview
                      
                      for q in questionJSON {
                          if (( !QuestionsDataSingleton.sharedInstance.sharedQuestions.contains(where: { $0.questionText ==  QuestionPresenter.present(entity: q).questionText}))) {
                              QuestionsDataSingleton.sharedInstance.sharedQuestions.append(QuestionPresenter.present(entity: q))
                          }
                      }
                  }
        
              }catch{
                  print(error) // shows error
                  print("Decoding failed")// local message
              }
                  
          }
      }
    
    //EINE VON DIESER ZWEI FUNKTIONEN AUSKOMENTIEREN DAMIT DIE DATEN VON FIREBASE BZW. VON question.json file //genommen werden
    
    
    override func viewDidLoad() {
  //getDataFromFirebase()
  getDataFromJSONFile()
    }
    
    
    
    //das Bestimmen der Werte in nächstem Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DVC") {
            let vc = segue.destination as! DificcultyViewController
            vc.name = name
            vc.filteredQuestions = self.filteredQuestions
            vc.gameType = gameType
            vc.categoryArray = categoryArray
        }
    }
    
    //navigieren zu Schwieriegsgrad Controller
    @objc func navigate(){
        //Alert view Controller wenn keine Kategorie ausgewählt wurde
        
        if(categoryArray.count == 0){
            let alertController = UIAlertController(title: "", message: "Es muss eine Kategorie ausgewählt werden!",preferredStyle: .alert)
            alertController.view.backgroundColor = UIColor.white
            let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
            alertController.view.addConstraint(height)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                // Perform Action
            })
            alertController.addAction(okAction)
            
            self.present(alertController ,animated: true)
        }
        else{
            self.performSegue(withIdentifier: "DVC", sender: self)
        }
        
    }
    @objc func selectall(){
        self.categoryView1.backgroundColor = UIColor.red
        self.categoryView2.backgroundColor = UIColor.red
        self.categoryView3.backgroundColor = UIColor.red
        self.categoryView4.backgroundColor = UIColor.red
        self.categoryView5.backgroundColor = UIColor.red
        self.categoryView6.backgroundColor = UIColor.red
        self.categoryView7.backgroundColor = UIColor.red
        self.categoryView8.backgroundColor = UIColor.red
        self.categoryView9.backgroundColor = UIColor.red
        self.categoryView10.backgroundColor = UIColor.red
        self.categoryView11.backgroundColor = UIColor.red
        self.categoryView12.backgroundColor = UIColor.red
        self.categoryView13.backgroundColor = UIColor.red
        self.categoryView14.backgroundColor = UIColor.red
        self.categoryView15.backgroundColor = UIColor.red
        self.categoryView16.backgroundColor = UIColor.red
        self.categoryView17.backgroundColor = UIColor.red
        self.categoryView18.backgroundColor = UIColor.red
        self.categoryView19.backgroundColor = UIColor.red
        self.categoryView20.backgroundColor = UIColor.red
        self.categoryView21.backgroundColor = UIColor.red
        self.categoryView22.backgroundColor = UIColor.red
        self.categoryView23.backgroundColor = UIColor.red
        self.categoryView24.backgroundColor = UIColor.red
        
        
        categoryArray = ["Entertainment: Film","General Knowledge","Entertainment: Books","Entertainment: Music","Entertainment: Musicals & Theatres","Entertainment: Television","Entertainment: Video Games","Science & Nature","Mithology","Sports","Geography","History","Politics","Art","Celebrities","Animals","Vehicles","Entertainment: Comics","Entertainment: Japanese Anime & Manga","Entertainment: Cartoon & Animations","Entertainment: Board Games","Science: Computers","Science: Mathematics"]
    }
    
    
    //funktion die ausgeführt wird beim Click auf irgendwelche Kategorie. Hier werden die fragen zu Array hinzugefügt, die bestimmte Kategorie haben
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if (tappedImage.image == UIImage(named: "knowledge")){
            
            
            if( self.categoryView1.backgroundColor == UIColor.red){
                self.categoryView1.backgroundColor = UIColor.white
                while categoryArray.contains("General Knowledge") {
                    if let itemToRemoveIndex = categoryArray.index(of: "General Knowledge") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
            }else if( self.categoryView1.backgroundColor == UIColor.white){
                self.categoryView1.backgroundColor = UIColor.red
                categoryArray.append("General Knowledge")
            }
        }else if (tappedImage.image == UIImage(named: "books")){
            if( self.categoryView2.backgroundColor == UIColor.red){
                while categoryArray.contains("Entertainment: Books") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Entertainment: Books") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                
                
                self.categoryView2.backgroundColor = UIColor.white
            }else if( self.categoryView2.backgroundColor == UIColor.white){
                categoryArray.append("Entertainment: Books")
                
                self.categoryView2.backgroundColor = UIColor.red
            }
        }
        else if (tappedImage.image == UIImage(named: "film")){
            if( self.categoryView3.backgroundColor == UIColor.red){
                while categoryArray.contains("Entertainment: Film") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Entertainment: Film") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView3.backgroundColor = UIColor.white
            }else if( self.categoryView3.backgroundColor == UIColor.white){
                categoryArray.append("Entertainment: Film")
                self.categoryView3.backgroundColor = UIColor.red
            }
            
            
        }
        else if (tappedImage.image == UIImage(named: "music")){
            if( self.categoryView4.backgroundColor == UIColor.red){
                while categoryArray.contains("Entertainment: Music") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Entertainment: Music") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                
                
                self.categoryView4.backgroundColor = UIColor.white
            }else if( self.categoryView4.backgroundColor == UIColor.white){
                categoryArray.append("Entertainment: Music")
                
                for q in QuestionsDataSingleton.sharedInstance.sharedQuestions{
                    
                    if(q.category == "Entertainment: Music"){
                        q.selected = true
                    }
                }
                
                self.categoryView4.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "theatres")){
            if( self.categoryView5.backgroundColor == UIColor.red){
                while categoryArray.contains("Entertainment: Musicals & Theatres") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Entertainment: Musicals & Theatres") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView5.backgroundColor = UIColor.white
            }else if( self.categoryView5.backgroundColor == UIColor.white){
                categoryArray.append("Entertainment: Musicals & Theatres")
                self.categoryView5.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "tv")){
            if( self.categoryView6.backgroundColor == UIColor.red){
                while categoryArray.contains("Entertainment: Television") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Entertainment: Television") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView6.backgroundColor = UIColor.white
            }else if( self.categoryView6.backgroundColor == UIColor.white){
                categoryArray.append("Entertainment: Television")
                self.categoryView6.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "games")){
            if( self.categoryView7.backgroundColor == UIColor.red){
                while categoryArray.contains("Entertainment: Video Games") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Entertainment: Video Games") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView7.backgroundColor = UIColor.white
            }else if( self.categoryView7.backgroundColor == UIColor.white){
                categoryArray.append("Entertainment: Video Games")
                self.categoryView7.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "board")){
            if( self.categoryView8.backgroundColor == UIColor.red){
                while categoryArray.contains("Entertainment: Board Games") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Entertainment: Board Games") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView8.backgroundColor = UIColor.white
            }else if( self.categoryView8.backgroundColor == UIColor.white){
                categoryArray.append("Entertainment: Board Games")
                self.categoryView8.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "nature-science")){
            if( self.categoryView9.backgroundColor == UIColor.red){
                while categoryArray.contains("Science & Nature") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Science & Nature") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView9.backgroundColor = UIColor.white
            }else if( self.categoryView9.backgroundColor == UIColor.white){
                categoryArray.append("Science & Nature")
                self.categoryView9.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "computers")){
            if( self.categoryView10.backgroundColor == UIColor.red){
                while categoryArray.contains("Science: Computers") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Science: Computers") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView10.backgroundColor = UIColor.white
            }else if( self.categoryView10.backgroundColor == UIColor.white){
                categoryArray.append("Science: Computers")
                self.categoryView10.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "math")){
            if( self.categoryView11.backgroundColor == UIColor.red){
                while categoryArray.contains("Science: Mathematics") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Science: Mathematics") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView11.backgroundColor = UIColor.white
            }else if( self.categoryView11.backgroundColor == UIColor.white){
                categoryArray.append("Science: Mathematics")
                self.categoryView11.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "mithology")){
            if( self.categoryView12.backgroundColor == UIColor.red){
                while categoryArray.contains("Mithology") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Mithology") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView12.backgroundColor = UIColor.white
            }else if( self.categoryView12.backgroundColor == UIColor.white){
                categoryArray.append("Mithology")
                self.categoryView12.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "sport")){
            if( self.categoryView13.backgroundColor == UIColor.red){
                while categoryArray.contains("Sports") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Sports") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView13.backgroundColor = UIColor.white
            }else if( self.categoryView13.backgroundColor == UIColor.white){
                categoryArray.append("Sports")
                self.categoryView13.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "geography")){
            if( self.categoryView14.backgroundColor == UIColor.red){
                while categoryArray.contains("Geography") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Geography") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView14.backgroundColor = UIColor.white
            }else if( self.categoryView14.backgroundColor == UIColor.white){
                categoryArray.append("Geography")
                self.categoryView14.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "History")){
            if( self.categoryView15.backgroundColor == UIColor.red){
                while categoryArray.contains("History") {
                    if let itemToRemoveIndex = categoryArray.index(of: "History") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView15.backgroundColor = UIColor.white
            }else if( self.categoryView15.backgroundColor == UIColor.white){
                categoryArray.append("History")
                self.categoryView15.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "Politics")){
            if( self.categoryView16.backgroundColor == UIColor.red){
                while categoryArray.contains("Politics") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Politics") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView16.backgroundColor = UIColor.white
            }else if( self.categoryView16.backgroundColor == UIColor.white){
                categoryArray.append("Politics")
                self.categoryView16.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "art")){
            if( self.categoryView17.backgroundColor == UIColor.red){
                while categoryArray.contains("Art") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Art") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView17.backgroundColor = UIColor.white
            }else if( self.categoryView17.backgroundColor == UIColor.white){
                categoryArray.append("Art")
                self.categoryView17.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "celeberties")){
            if( self.categoryView18.backgroundColor == UIColor.red){
                while categoryArray.contains("Celebrities") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Celebrities") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView18.backgroundColor = UIColor.white
            }else if( self.categoryView18.backgroundColor == UIColor.white){
                categoryArray.append("Celebrities")
                self.categoryView18.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "koala")){
            if( self.categoryView19.backgroundColor == UIColor.red){
                while categoryArray.contains("Animals") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Animals") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView19.backgroundColor = UIColor.white
            }else if( self.categoryView19.backgroundColor == UIColor.white){
                categoryArray.append("Animal")
                self.categoryView19.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "vehicles")){
            if( self.categoryView20.backgroundColor == UIColor.red){
                while categoryArray.contains("Vehicles") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Vehicles") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView20.backgroundColor = UIColor.white
            }else if( self.categoryView20.backgroundColor == UIColor.white){
                categoryArray.append("Vehicles")
                self.categoryView20.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "comics")){
            if( self.categoryView21.backgroundColor == UIColor.red){
                while categoryArray.contains("Entertainment: Comics") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Entertainment: Comics") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView21.backgroundColor = UIColor.white
            }else if( self.categoryView21.backgroundColor == UIColor.white){
                categoryArray.append("Entertainment: Comics")
                self.categoryView21.backgroundColor = UIColor.red
            }
            
        }
        else if (tappedImage.image == UIImage(named: "japanese")){
            if( self.categoryView22.backgroundColor == UIColor.red){
                while categoryArray.contains("Entertainment: Japanese Anime & Manga") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Entertainment: Japanese Anime & Manga") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView22.backgroundColor = UIColor.white
            }else if( self.categoryView22.backgroundColor == UIColor.white){
                categoryArray.append("Entertainment: Japanese Anime & Manga")
                self.categoryView22.backgroundColor = UIColor.red
            }
        }
        else if (tappedImage.image == UIImage(named: "cartoon")){
            if( self.categoryView23.backgroundColor == UIColor.red){
                while categoryArray.contains("Entertainment: Cartoon & Animations") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Entertainment: Cartoon & Animations") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView23.backgroundColor = UIColor.white
            }else if( self.categoryView23.backgroundColor == UIColor.white){
                categoryArray.append("Entertainment: Cartoon & Animations")
                self.categoryView23.backgroundColor = UIColor.red
            }
        }
        else if (tappedImage.image == UIImage(named: "cartoon")){
            if( self.categoryView24.backgroundColor == UIColor.red){
                while categoryArray.contains("Entertainment: Cartoon & Animations") {
                    if let itemToRemoveIndex = categoryArray.index(of: "Entertainment: Cartoon & Animations") {
                        categoryArray.remove(at: itemToRemoveIndex)
                    }
                }
                self.categoryView24.backgroundColor = UIColor.white
            }else if( self.categoryView24.backgroundColor == UIColor.white){
                categoryArray.append("Entertainment: Cartoon & Animations")
                self.categoryView24.backgroundColor = UIColor.red
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let headerView = UIView(frame: CGRect(x: 0, y: 32, width: view.frame.size.width, height: 60))
        headerView.backgroundColor = .systemTeal
        view.addSubview(headerView)
        let headerLabel = UILabel(frame: CGRect(x: 177, y: 18, width: 43, height: 25));
        headerLabel.text = "Quiz"
        headerView.addSubview(headerLabel)
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 100, width: view.frame.size.width,
                                                    height: 650  ))
        scrollView.backgroundColor = .yellow
        view.addSubview(scrollView)
        
        let saveButton = UIButton(frame: CGRect(x: 28, y: 760, width: 359, height: 70))
        
        saveButton.backgroundColor = UIColor.green
        saveButton.setTitle("Speichern", for: .normal)
        saveButton.titleLabel?.font =  UIFont(name: "Arial", size: 35)
        saveButton.addTarget(self, action: #selector(navigate), for: .touchUpInside)
        // Add self as a target
        view.addSubview(saveButton)
        
        let buttonAllCategories = UIButton(frame: CGRect(x: 28, y: 2900, width: 359, height: 70))
        buttonAllCategories.backgroundColor = UIColor.green
        
        scrollView.addSubview(buttonAllCategories)
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 3200)
        buttonAllCategories.setTitle("Alle Kategorien", for: .normal)
        buttonAllCategories.titleLabel?.font =  UIFont(name: "Arial", size: 35)
        buttonAllCategories.addTarget(self, action: #selector(selectall), for: .touchUpInside)
        
        self.categoryView1 = UIView(frame: CGRect(x: 20, y: 20, width: 175, height: 220))
        
        categoryView1.backgroundColor = .white
        
        let imageView1 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView1.image = UIImage(named: "knowledge")
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView1.isUserInteractionEnabled = true
        imageView1.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        
        let categoryLabel1 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel1.text = "General Knowledge"
        categoryView1.addSubview(categoryLabel1)
        categoryView1.addSubview(imageView1)
        
        scrollView.addSubview(categoryView1)
        
        self.categoryView2 = UIView(frame: CGRect(x: 220, y: 20, width: 175, height: 220))
        categoryView2.backgroundColor = .white
        
        let imageView2 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView2.image = UIImage(named: "books")
        
        
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView2.isUserInteractionEnabled = true
        imageView2.addGestureRecognizer(tapGestureRecognizer2)
        
        
        
        let categoryLabel2 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel2.text = "Entertainment: Books"
        categoryView2.addSubview(categoryLabel2)
        categoryView2.addSubview(imageView2)
        scrollView.addSubview(categoryView2)
        
        self.categoryView3 = UIView(frame: CGRect(x: 20, y: 260, width: 175, height: 220))
        categoryView3.backgroundColor = .white
        
        let imageView3 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView3.image = UIImage(named: "film")
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView3.isUserInteractionEnabled = true
        imageView3.addGestureRecognizer(tapGestureRecognizer3)
        
        
        
        let categoryLabel3 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel3.text = "Entertainment: Film"
        categoryView3.addSubview(categoryLabel3)
        categoryView3.addSubview(imageView3)
        scrollView.addSubview(categoryView3)
        
        
        
        self.categoryView4 = UIView(frame: CGRect(x: 220, y: 260, width: 175, height: 220))
        categoryView4.backgroundColor = .white
        
        let imageView4 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView4.image = UIImage(named: "music")
        
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView4.isUserInteractionEnabled = true
        imageView4.addGestureRecognizer(tapGestureRecognizer4)
        
        
        
        let categoryLabel4 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel4.text = "Entertainment: Music"
        categoryView4.addSubview(categoryLabel4)
        categoryView4.addSubview(imageView4)
        scrollView.addSubview(categoryView4)
        
        
        
        
        
        self.categoryView5 = UIView(frame: CGRect(x: 20, y: 500, width: 175, height: 220))
        categoryView5.backgroundColor = .white
        
        let imageView5 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView5.image = UIImage(named: "theatres")
        
        let tapGestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView5.isUserInteractionEnabled = true
        imageView5.addGestureRecognizer(tapGestureRecognizer5)
        
        let categoryLabel5 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel5.text = "Entertainment: Musicals & Theaters"
        categoryView5.addSubview(categoryLabel5)
        categoryView5.addSubview(imageView5)
        scrollView.addSubview(categoryView5)
        
        
        
        self.categoryView6 = UIView(frame: CGRect(x: 220, y: 500, width: 175, height: 220))
        categoryView6.backgroundColor = .white
        
        let imageView6 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView6.image = UIImage(named: "tv")
        
        let tapGestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView6.isUserInteractionEnabled = true
        imageView6.addGestureRecognizer(tapGestureRecognizer6)
        
        
        let categoryLabel6 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel6.text = "Entertainment: Television"
        categoryView6.addSubview(categoryLabel6)
        categoryView6.addSubview(imageView6)
        scrollView.addSubview(categoryView6)
        
        
        
        
        self.categoryView7 = UIView(frame: CGRect(x: 20, y: 740, width: 175, height: 220))
        categoryView7.backgroundColor = .white
        
        let imageView7 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView7.image = UIImage(named: "games")
        
        
        
        let tapGestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView7.isUserInteractionEnabled = true
        imageView7.addGestureRecognizer(tapGestureRecognizer7)
        
        let categoryLabel7 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel7.text = "Entertainment: Video Games"
        categoryView7.addSubview(categoryLabel7)
        categoryView7.addSubview(imageView7)
        scrollView.addSubview(categoryView7)
        
        
        
        self.categoryView8 = UIView(frame: CGRect(x: 220, y: 740, width: 175, height: 220))
        categoryView8.backgroundColor = .white
        
        let imageView8 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView8.image = UIImage(named: "board")
        
        
        let tapGestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView8.isUserInteractionEnabled = true
        imageView8.addGestureRecognizer(tapGestureRecognizer8)
        
        let categoryLabel8 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel8.text = "Entertainment: Board Games"
        categoryView8.addSubview(categoryLabel8)
        categoryView8.addSubview(imageView8)
        scrollView.addSubview(categoryView8)
        
        
        
        
        self.categoryView9 = UIView(frame: CGRect(x: 20, y: 980, width: 175, height: 220))
        categoryView9.backgroundColor = .white
        
        let imageView9 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView9.image = UIImage(named: "nature-science")
        
        
        let tapGestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView9.isUserInteractionEnabled = true
        imageView9.addGestureRecognizer(tapGestureRecognizer9)
        
        let categoryLabel9 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel9.text = "Science & Nature"
        categoryView9.addSubview(categoryLabel9)
        categoryView9.addSubview(imageView9)
        scrollView.addSubview(categoryView9)
        
        
        
        self.categoryView10 = UIView(frame: CGRect(x: 220, y: 980, width: 175, height: 220))
        categoryView10.backgroundColor = .white
        
        let imageView10 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView10.image = UIImage(named: "computers")
        
        
        
        let tapGestureRecognizer10 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView10.isUserInteractionEnabled = true
        imageView10.addGestureRecognizer(tapGestureRecognizer10)
        
        let categoryLabel10 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel10.text = "Science: Computers"
        categoryView10.addSubview(categoryLabel10)
        categoryView10.addSubview(imageView10)
        scrollView.addSubview(categoryView10)
        
        
        
        self.categoryView11 = UIView(frame: CGRect(x: 20, y: 1220, width: 175, height: 220))
        categoryView11.backgroundColor = .white
        
        let imageView11 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView11.image = UIImage(named: "math")
        
        
        
        let tapGestureRecognizer11 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView11.isUserInteractionEnabled = true
        imageView11.addGestureRecognizer(tapGestureRecognizer11)
        
        let categoryLabel11 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel11.text = "Science: Mathematics"
        categoryView11.addSubview(categoryLabel11)
        categoryView11.addSubview(imageView11)
        scrollView.addSubview(categoryView11)
        
        
        
        self.categoryView12 = UIView(frame: CGRect(x: 220, y: 1220, width: 175, height: 220))
        categoryView12.backgroundColor = .white
        
        let imageView12 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView12.image = UIImage(named: "mithology")
        
        
        let tapGestureRecognizer12 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView12.isUserInteractionEnabled = true
        imageView12.addGestureRecognizer(tapGestureRecognizer12)
        
        let categoryLabel12 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel12.text = "Mythology"
        categoryView12.addSubview(categoryLabel12)
        categoryView12.addSubview(imageView12)
        scrollView.addSubview(categoryView12)
        
        
        
        self.categoryView13 = UIView(frame: CGRect(x: 20, y: 1460, width: 175, height: 220))
        categoryView13.backgroundColor = .white
        
        let imageView13 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView13.image = UIImage(named: "sport")
        
        
        let tapGestureRecognizer13 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView13.isUserInteractionEnabled = true
        imageView13.addGestureRecognizer(tapGestureRecognizer13)
        
        let categoryLabel13 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel13.text = "Sports"
        categoryView13.addSubview(categoryLabel13)
        categoryView13.addSubview(imageView13)
        scrollView.addSubview(categoryView13)
        
        
        
        self.categoryView14 = UIView(frame: CGRect(x: 220, y: 1460, width: 175, height: 220))
        categoryView14.backgroundColor = .white
        
        let imageView14 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView14.image = UIImage(named: "geography")
        
        
        let tapGestureRecognizer14 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView14.isUserInteractionEnabled = true
        imageView14.addGestureRecognizer(tapGestureRecognizer14)
        
        let categoryLabel14 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel14.text = "Geography"
        categoryView14.addSubview(categoryLabel14)
        categoryView14.addSubview(imageView14)
        scrollView.addSubview(categoryView14)
        
        
        
        self.categoryView15 = UIView(frame: CGRect(x: 20, y: 1700, width: 175, height: 220))
        categoryView15.backgroundColor = .white
        
        let imageView15 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView15.image = UIImage(named: "history")
        
        
        let tapGestureRecognizer15 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView15.isUserInteractionEnabled = true
        imageView15.addGestureRecognizer(tapGestureRecognizer15)
        
        let categoryLabel15 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel15.text = "History"
        categoryView15.addSubview(categoryLabel15)
        categoryView15.addSubview(imageView15)
        scrollView.addSubview(categoryView15)
        
        
        
        self.categoryView16 = UIView(frame: CGRect(x: 220, y: 1700, width: 175, height: 220))
        categoryView16.backgroundColor = .white
        
        let imageView16 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView16.image = UIImage(named: "politics")
        
        let tapGestureRecognizer16 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView16.isUserInteractionEnabled = true
        imageView16.addGestureRecognizer(tapGestureRecognizer16)
        
        
        let categoryLabel16 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel16.text = "Politics"
        categoryView16.addSubview(categoryLabel16)
        categoryView16.addSubview(imageView16)
        scrollView.addSubview(categoryView16)
        
        
        
        self.categoryView17 = UIView(frame: CGRect(x: 20, y: 1940, width: 175, height: 220))
        categoryView17.backgroundColor = .white
        
        let imageView17 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView17.image = UIImage(named: "art")
        
        
        
        let tapGestureRecognizer17 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView17.isUserInteractionEnabled = true
        imageView17.addGestureRecognizer(tapGestureRecognizer17)
        
        let categoryLabel17 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel17.text = "Art"
        categoryView17.addSubview(categoryLabel17)
        categoryView17.addSubview(imageView17)
        scrollView.addSubview(categoryView17)
        
        
        
        self.categoryView18 = UIView(frame: CGRect(x: 220, y: 1940, width: 175, height: 220))
        categoryView18.backgroundColor = .white
        
        let imageView18 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView18.image = UIImage(named: "celeberties")
        
        
        
        let tapGestureRecognizer18 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView18.isUserInteractionEnabled = true
        imageView18.addGestureRecognizer(tapGestureRecognizer18)
        
        let categoryLabel18 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel18.text = "Celebrities"
        categoryView18.addSubview(categoryLabel18)
        categoryView18.addSubview(imageView18)
        scrollView.addSubview(categoryView18)
        
        
        
        self.categoryView19 = UIView(frame: CGRect(x: 20, y: 2180, width: 175, height: 220))
        categoryView19.backgroundColor = .white
        
        let imageView19 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView19.image = UIImage(named: "koala")
        
        
        
        let tapGestureRecognizer19 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView19.isUserInteractionEnabled = true
        imageView19.addGestureRecognizer(tapGestureRecognizer19)
        
        let categoryLabel19 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel19.text = "Animals"
        categoryView19.addSubview(categoryLabel19)
        categoryView19.addSubview(imageView19)
        scrollView.addSubview(categoryView19)
        
        
        
        self.categoryView20 = UIView(frame: CGRect(x: 220, y: 2180, width: 175, height: 220))
        categoryView20.backgroundColor = .white
        
        let imageView20 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView20.image = UIImage(named: "vehicles")
        
        
        let tapGestureRecognizer20 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView20.isUserInteractionEnabled = true
        imageView20.addGestureRecognizer(tapGestureRecognizer20)
        
        let categoryLabel20 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel20.text = "Vehicles"
        categoryView20.addSubview(categoryLabel20)
        categoryView20.addSubview(imageView20)
        scrollView.addSubview(categoryView20)
        
        
        self.categoryView21 = UIView(frame: CGRect(x: 20, y: 2420, width: 175, height: 220))
        categoryView21.backgroundColor = .white
        
        let imageView21 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView21.image = UIImage(named: "comics")
        
        
        let tapGestureRecognizer21 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView21.isUserInteractionEnabled = true
        imageView21.addGestureRecognizer(tapGestureRecognizer21)
        
        let categoryLabel21 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel21.text = "Entertainment: Comics"
        categoryView21.addSubview(categoryLabel21)
        categoryView21.addSubview(imageView21)
        scrollView.addSubview(categoryView21)
        
        self.categoryView22 = UIView(frame: CGRect(x: 220, y: 2420, width: 175, height: 220))
        categoryView22.backgroundColor = .white
        
        let imageView22 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView22.image = UIImage(named: "japanese")
        
        
        let tapGestureRecognizer22 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView22.isUserInteractionEnabled = true
        imageView22.addGestureRecognizer(tapGestureRecognizer22)
        
        let categoryLabel22 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel22.text = "Entertainment: Japanese Anime & Manga"
        categoryView22.addSubview(categoryLabel22)
        categoryView22.addSubview(imageView22)
        scrollView.addSubview(categoryView22)
        
        
        
        self.categoryView23 = UIView(frame: CGRect(x: 20, y: 2660, width: 175, height: 220))
        categoryView23.backgroundColor = .white
        
        let imageView23 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView23.image = UIImage(named: "cartoon")
        
        
        let tapGestureRecognizer23 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView23.isUserInteractionEnabled = true
        imageView23.addGestureRecognizer(tapGestureRecognizer23)
        
        let categoryLabel23 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel23.text = "Entertainment: Cartoon & Animations"
        categoryView23.addSubview(categoryLabel23)
        categoryView23.addSubview(imageView23)
        scrollView.addSubview(categoryView23)
        
        self.categoryView24 = UIView(frame: CGRect(x: 220, y: 2660, width: 175, height: 220))
        categoryView24.backgroundColor = .white
        
        let imageView24 = UIImageView(frame: CGRect(x: 10, y: 5, width: 155, height: 155))
        imageView24.image = UIImage(named: "cartoon")
        
        let tapGestureRecognizer24 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView24.isUserInteractionEnabled = true
        imageView24.addGestureRecognizer(tapGestureRecognizer24)
        
        let categoryLabel24 = UILabel(frame: CGRect(x: 10, y: 165, width: 165 , height: 40))
        categoryLabel24.text = "Entertainment: Games"
        categoryView24.addSubview(categoryLabel24)
        categoryView24.addSubview(imageView24)
        scrollView.addSubview(categoryView24)
        
        
        
        
        
    }
}
