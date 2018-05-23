//
//  AddBunchHeroesControllerView.swift
//  Pangolier
//
//  Created by Homac on 5/17/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddBunchHeroesViewController: UIViewController {
  
  var ref : DatabaseReference!
  
  var heroes: [HeroModel] = []
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var bunchNameTextField: UITextField!
  @IBOutlet weak var bunchDescTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
      do {
        try Auth.auth().signOut()
      } catch let error as NSError {
      }
    
    if Auth.auth().currentUser == nil {
      let loginVC = LoginViewController()
      
      loginVC.modalTransitionStyle = .crossDissolve
      loginVC.modalPresentationStyle = .overCurrentContext
      
      navigationController?.present(loginVC, animated: true)
    }
    
    ref = Database.database().reference()
  }
  
  @IBAction func addHeroAction(_ sender: Any) {
    print(heroes)
    if heroes.count<5 {
      let heroesVC = storyboard?.instantiateViewController(withIdentifier: "HeroesViewController") as! HeroesViewController
      heroesVC.delegate = self
      navigationController?.pushViewController(heroesVC, animated: true)
    }
  }
  
  @IBAction func saveButton(_ sender: Any) {
    var heroesIds : [Int] = []
    for hero in heroes {
      heroesIds.append(hero.id)
    }
    
    let sendDictionary = ["name" : bunchNameTextField.text ?? "noname",
                          "heroes" : heroesIds,
                          "desc" : bunchDescTextView.text ?? "nodesc"] as [String : Any]
    
    
    self.ref.child("bunch").childByAutoId().setValue(sendDictionary)
  }
  
}

extension AddBunchHeroesViewController: UICollectionViewDelegate, UICollectionViewDataSource, GetHeroDelegat{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return heroes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
    
    cell.setHeroImage(hero: heroes[indexPath.row])
    
    return cell
  }
  
  func didSelect(hero: HeroModel) {
    heroes.append(hero)
    collectionView.reloadData()
  }
  
}

protocol GetHeroDelegat: class {
  
  func didSelect(hero: HeroModel)
  
}
