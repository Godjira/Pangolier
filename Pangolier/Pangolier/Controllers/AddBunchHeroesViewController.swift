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

  var heroes: [HeroModel] = []

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var bunchNameTextField: UITextField!
  @IBOutlet weak var bunchDescTextView: PanTextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    initToolBarForKeyboard()
    
    if Auth.auth().currentUser == nil {
      let loginVC = LoginViewController()
      loginVC.modalTransitionStyle = .crossDissolve
      loginVC.modalPresentationStyle = .overCurrentContext
      navigationController?.present(loginVC, animated: true)
    }
    bunchDescTextView.textColor = UIColor.white
  }

  func initToolBarForKeyboard() {
    //init toolbar
    let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))

    //create left side empty space so that done button set on right side
    let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)

    let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(AddBunchHeroesViewController.doneButtonAction))

    toolbar.setItems([flexSpace, doneBtn], animated: false)
    toolbar.sizeToFit()

    //setting toolbar as inputAccessoryView
    self.bunchNameTextField.inputAccessoryView = toolbar
    self.bunchDescTextView.inputAccessoryView = toolbar
  }

  @objc func doneButtonAction() {
    self.view.endEditing(true)

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  @IBAction func addHeroAction(_ sender: Any) {
    guard let multipleHeroesViewController = storyboard?
      .instantiateViewController(withIdentifier: "MultipleHeroesViewController") as? MultipleHeroesViewController else { return }
    multipleHeroesViewController.delegate = self
    navigationController?.pushViewController(multipleHeroesViewController, animated: true)
  }

  @IBAction func saveButton(_ sender: Any) {
    if Auth.auth().currentUser == nil {
      let loginVC = LoginViewController()
      loginVC.modalTransitionStyle = .crossDissolve
      loginVC.modalPresentationStyle = .overCurrentContext
      navigationController?.present(loginVC, animated: true)
    } else {
      if bunchDescTextView.text != "" && bunchNameTextField.text != "" && self.heroes.count > 1 {
        let bunch = BunchModel.init(id: "",
                                    name: bunchNameTextField.text!,
                                    userId: (Auth.auth().currentUser?.uid)!,
                                    heroesId: self.heroes.map { $0.id },
                                    description: bunchDescTextView.getPlainText(),
                                    rate: [(Auth.auth().currentUser?.uid)!])
        BunchManager.sendBunch(bunch: bunch)
        self.navigationController?.popViewController(animated: true)
      }
    }
  }

  @IBAction func getStringAction(_ sender: Any) {
    let plainText = bunchDescTextView.getPlainText()
    bunchDescTextView.text = ""
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.bunchDescTextView.attributedText = self.bunchDescTextView.setPlainStringWithImage(plainString: plainText)
    }
  }

  @IBAction func addHeroInTextViewAction(_ sender: Any) {
    guard let multHeroesVC = storyboard?
      .instantiateViewController(withIdentifier: "MultipleHeroesViewController") as? MultipleHeroesViewController else { return }

    multHeroesVC.delegateHeroesAttr = self
    self.navigationController?.pushViewController(multHeroesVC, animated: true)
  }

  @IBAction func addItemInTextViewAction(_ sender: UIButton) {
    guard let itemsVC = storyboard?
      .instantiateViewController(withIdentifier: "ItemsViewController") as? ItemsViewController else { return }

    itemsVC.delegate = self
    self.navigationController?.pushViewController(itemsVC, animated: true)
  }
}

extension AddBunchHeroesViewController: UICollectionViewDelegate, UICollectionViewDataSource, GetHeroesDelegat,
GetItemDelegate, GetHeroesAttrDelegate {

  func didSelect(items: [ItemModel]) {
    for item in items {
      bunchDescTextView.addImageFromAssets(imageName: item.name)
    }
  }

  func getHeroesAttr(heroes: [HeroModel]) {
    for hero in heroes {
      bunchDescTextView.addImageFromAssets(imageName: hero.name)
    }
  }

  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    return false
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return heroes.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemOrHeroCollectionViewCell", for: indexPath)
as? ItemOrHeroCollectionViewCell else { return UICollectionViewCell() }

    cell.setHeroImage(hero: heroes[indexPath.row])
    return cell
  }

  func didSelect(heroes: [HeroModel]) {
    self.heroes = heroes
    collectionView.reloadData()
  }
}
