//
//  BaseHeroesViewController.swift
//  Pangolier
//
//  Created by Homac on 5/28/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import UIKit

class BaseHeroesViewController: UIViewController {
  
  @IBOutlet weak var collectonView: UICollectionView!
  var heroes = [HeroModel]()
  var groupHeroes: [[HeroModel]] = [[]]
  
  let sections: [(title: String, color: UIColor)] = [("Strange", .red),
                                                     ("Agility", .green),
                                                     ("Intelect", .blue)]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Get instets
    let colletctionViewLayout = self.collectonView.collectionViewLayout as! UICollectionViewFlowLayout
    colletctionViewLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10)
    
    HeroManager.getHeroes { (heroesArray) in
      self.heroes = heroesArray
      self.collectonView.reloadData()
      // Get sort heroes
      self.groupHeroes = HeroManager.getSortHeroesWithAttributes(heroes: self.heroes)
    }
  }

  
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension BaseHeroesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int{
    print(groupHeroes.count)
    return groupHeroes.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return groupHeroes[section].count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
    cell.setHeroImage(hero: self.groupHeroes[indexPath.section][indexPath.row])
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    var reusableView = UICollectionReusableView()
    
    if kind == UICollectionElementKindSectionHeader {
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
      
      let section = sections[indexPath.section]
      
      headerView.titleLabel.text = section.title
      headerView.titleLabel.textColor = section.color
      reusableView = headerView
      //headerView.imageView.image = UIImage(named: )
      
    }
    return reusableView
  }
  

  

  
  
  
}
