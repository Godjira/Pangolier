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
//    do {
//      try Auth.auth().signOut()
//    } catch let error as NSError {
//    }
    if Auth.auth().currentUser == nil {
      let loginVC = LoginViewController()
      
      loginVC.modalTransitionStyle = .crossDissolve
      loginVC.modalPresentationStyle = .overCurrentContext
      
      navigationController?.present(loginVC, animated: true)
    }
    
    ref = Database.database().reference()
  }
  
  @IBAction func addHeroAction(_ sender: Any) {
      let heroesVC = storyboard?.instantiateViewController(withIdentifier: "HeroesViewController") as! HeroesViewController
      heroesVC.delegate = self
      navigationController?.pushViewController(heroesVC, animated: true)
  }
  
  @IBAction func saveButton(_ sender: Any) {
    if Auth.auth().currentUser == nil {
      let loginVC = LoginViewController()
      
      loginVC.modalTransitionStyle = .crossDissolve
      loginVC.modalPresentationStyle = .overCurrentContext
      
      navigationController?.present(loginVC, animated: true)
    } else {
      if heroes.count > 1 {
        var heroesId: [Int] = []
        for hero in heroes {
          heroesId.append(hero.id)
        }
        for id in heroesId {
          let sendDictionary = ["name" : bunchNameTextField.text ?? "noname",
                                "user" : Auth.auth().currentUser?.uid ?? "",
                                "heroes" : heroesId,
                                "desc" : bunchDescTextView.text ?? "nodesc"] as [String : Any]
          
          self.ref.child("bunch").child(String(id)).childByAutoId().setValue(sendDictionary)
        }
        navigationController?.popViewController(animated: true)
      }
    }
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
  
  func didSelect(heroes: [HeroModel]) {
    self.heroes = heroes
    collectionView.reloadData()
  }
  
}

protocol GetHeroDelegat: class {
  
  func didSelect(heroes: [HeroModel])
  
}
