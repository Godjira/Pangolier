//
//  MultipleHeroesViewController.swift
//  Pangolier
//
//  Created by Homac on 5/29/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import UIKit

class MultipleHeroesViewController: BaseHeroesViewController {
  
   weak var delegate: GetHeroesDelegat?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let item = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(MultipleHeroesViewController.saveHeroBunchAction))
    navigationItem.rightBarButtonItem = item
    collectionView.allowsMultipleSelection = true
    
  }
  
  @objc func saveHeroBunchAction() {
    print("tap save")
    var saveHeroes: [HeroModel] = []
    for indexPath in collectionView.indexPathsForSelectedItems!{
      saveHeroes.append(self.groupHeroes[indexPath.section][indexPath.row])
    }
    self.delegate?.didSelect(heroes: saveHeroes)
    navigationController?.popViewController(animated: true)
  }
  
  
  
  //MARK: - CollectionDelegate and DataSource
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    if (collectionView.indexPathsForSelectedItems?.count)! < 5 {
      return true
    }
    return false
  }
  
}

protocol GetHeroesDelegat: class {
  
  func didSelect(heroes: [HeroModel])
  
}
