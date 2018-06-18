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
  @IBOutlet weak var bunchDescTextView: UIPanTextView!
  
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
      if bunchDescTextView.text != "" && bunchNameTextField.text != "" && self.heroes.count > 1 {
      let bunch = BunchModel.init(id: "",name: bunchNameTextField.text!, userId: (Auth.auth().currentUser?.uid)!, heroesId: self.heroes.map { $0.id }, description: bunchDescTextView.getPlainText(), rate: [(Auth.auth().currentUser?.uid)!])
      BunchManager.sendBunch(bunch: bunch)
      self.navigationController?.popViewController(animated: true)
    }
    }
  }
  
  
  @IBAction func getStringAction(_ sender: Any) {
    let plainText = bunchDescTextView.getPlainText()
    bunchDescTextView.text = ""

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.bunchDescTextView.attributedText = self.bunchDescTextView.setPlainStringWithImage(plain_string: plainText)
    }
  }
  
  @IBAction func addHeroInTextViewAction(_ sender: Any) {
    let multHeroesVC = storyboard?.instantiateViewController(withIdentifier: "MultipleHeroesViewController") as! MultipleHeroesViewController
    multHeroesVC.delegateHeroesAttr = self
    self.navigationController?.pushViewController(multHeroesVC, animated: true)
  }
  
  @IBAction func addItemInTextViewAction(_ sender: UIButton) {
    let itemsVC = storyboard?.instantiateViewController(withIdentifier: "ItemsViewController") as! ItemsViewController
    itemsVC.delegate = self
    self.navigationController?.pushViewController(itemsVC, animated: true)
  }
}

extension AddBunchHeroesViewController: UICollectionViewDelegate, UICollectionViewDataSource, GetHeroesDelegat, GetItemDelegate, GetHeroesAttrDelegate{
  
  func didSelect(items: [ItemModel]) {
    for item in items {
      bunchDescTextView.addImageFromAssets(image_name:item.name)
    }
  }
  
  func getHeroesAttr(heroes: [HeroModel]) {
    for hero in heroes {
      bunchDescTextView.addImageFromAssets(image_name:hero.name)
    }
  }
  
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




