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
    if Auth.auth().currentUser == nil {
      let loginVC = LoginViewController()
      
      loginVC.modalTransitionStyle = .crossDissolve
      loginVC.modalPresentationStyle = .overCurrentContext
      
      navigationController?.present(loginVC, animated: true)
    }
    ref = Database.database().reference()
  }
  
  @IBAction func addHeroAction(_ sender: Any) {
      let multipleHeroesVC = storyboard?.instantiateViewController(withIdentifier: "MultipleHeroesViewController") as! MultipleHeroesViewController
      multipleHeroesVC.delegate = self
      navigationController?.pushViewController(multipleHeroesVC, animated: true)
  }
  
  @IBAction func saveButton(_ sender: Any) {
    if Auth.auth().currentUser == nil {
      let loginVC = LoginViewController()
      
      loginVC.modalTransitionStyle = .crossDissolve
      loginVC.modalPresentationStyle = .overCurrentContext
      
      navigationController?.present(loginVC, animated: true)
    } else {
      let bunch = BunchModel.init(id: "",name: bunchNameTextField.text!, userId: (Auth.auth().currentUser?.uid)!, heroesId: self.heroes.map { $0.id }, description: bunchDescTextView.text!, rate: [(Auth.auth().currentUser?.uid)!])
      BunchManager.sendBunch(bunch: bunch)
      self.navigationController?.popViewController(animated: true)
    }
  }
}

extension AddBunchHeroesViewController: UICollectionViewDelegate, UICollectionViewDataSource, GetHeroesDelegat{
  
  
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
   return false
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return heroes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemOrHeroCollectionViewCell", for: indexPath) as! ItemOrHeroCollectionViewCell
    
    cell.setHeroImage(hero: heroes[indexPath.row])
    
    return cell
  }
  
  func didSelect(heroes: [HeroModel]) {
    self.heroes = heroes
    collectionView.reloadData()
  }
  
}


