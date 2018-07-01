//
//  SingleHeroesViewController.swift
//  Pangolier
//
//  Created by Homac on 5/30/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import UIKit

class SingleHeroesViewController: BaseHeroesViewController {
  
  weak var delegate: GetHeroDelegat?

  override func viewDidLoad() {
    super.viewDidLoad()

    let item = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(MultipleHeroesViewController.saveHeroBunchAction))
    navigationItem.rightBarButtonItem = item
    self.collectionView.allowsMultipleSelection = true
  }
  // MARK: - CollectionDelegate and DataSource
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.didSelect(hero: self.groupHeroes[indexPath.section][indexPath.row])
    self.dismiss(animated: true)
  }
}

protocol GetHeroDelegat: class {
  func didSelect(hero: HeroModel)
}
