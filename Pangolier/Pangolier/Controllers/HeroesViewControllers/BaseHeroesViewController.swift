//
//  BaseHeroesViewController.swift
//  Pangolier
//
//  Created by Homac on 5/28/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import UIKit

class BaseHeroesViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var heroes = [HeroModel]()
  var groupHeroes: [[HeroModel]] = [[]]

  let sections: [(title: String, image: UIImage)] = [("Strength", #imageLiteral(resourceName: "red")),
                                                     ("Agility", #imageLiteral(resourceName: "green")),
                                                     ("Intellect", #imageLiteral(resourceName: "blue"))]

  override func viewDidLoad() {
    super.viewDidLoad()
    // Get instets
    guard let colletctionViewLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
    colletctionViewLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10)
    HeroManager.getHeroes { (heroesArray) in
      self.heroes = heroesArray
      // Get sort heroes
      self.groupHeroes = HeroManager.getSortHeroesWithAttributes(heroes: self.heroes)
      self.collectionView.reloadData()
    }
  }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension BaseHeroesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    print(groupHeroes.count)
    return groupHeroes.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return groupHeroes[section].count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemOrHeroCollectionViewCell", for: indexPath)
      as? ItemOrHeroCollectionViewCell else { return UICollectionViewCell() }
    cell.setHeroImage(hero: self.groupHeroes[indexPath.section][indexPath.row])

    return cell
  }

  private func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionViewCell {

    var reusableView = UICollectionReusableView()
    if kind == UICollectionElementKindSectionHeader {
      guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
              withReuseIdentifier: "HeaderCollectionReusableView",
              for: indexPath) as? HeaderCollectionReusableView else { return UICollectionViewCell() }

      let section = sections[indexPath.section]

      headerView.titleLabel.text = section.title
      headerView.imageView.image = section.image
      reusableView = headerView
    }

    guard let cell = reusableView as? UICollectionViewCell else { return UICollectionViewCell() }
    return cell
  }
}
