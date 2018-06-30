//
//  SingleHeroesViewController.swift
//  Pangolier
//
//  Created by Homac on 5/29/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainHeroesViewController: BaseHeroesViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Choose hero"

    let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MainHeroesViewController.addButtonAction))
    navigationItem.rightBarButtonItem = item
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let selectedHero = groupHeroes[indexPath.section][indexPath.row]
    guard let heroVC = storyboard?.instantiateViewController(withIdentifier: "HeroViewController") as? HeroViewController else { return }
    heroVC.hero = selectedHero
    heroVC.allHeroes = self.heroes
    navigationController?.pushViewController(heroVC, animated: true)
  }

  @objc func addButtonAction() {
    guard let addBunchVC = storyboard?
      .instantiateViewController(withIdentifier: "AddBunchHeroesViewController") as? AddBunchHeroesViewController else { return }
    navigationController?.pushViewController(addBunchVC, animated: true)
  }

}
