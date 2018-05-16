//
//  HeroesViewController.swift
//  Pangolier
//
//  Created by Homac on 5/16/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import UIKit
import Firebase

class HeroesViewController: UIViewController {

  @IBOutlet weak var collectonView: UICollectionView!
  var heroes = [HeroModel]()
  var groupHeroes: [[HeroModel]] = [[]]

  override func viewDidLoad() {
    super.viewDidLoad()
    FirebaseApp.configure()
    
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

extension HeroesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
    var title = ""
    var textColor = UIColor.black

    if kind == UICollectionElementKindSectionHeader {
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
      switch indexPath.section {
        
      case 0:
        title = "Strange"
        textColor = UIColor.red
      case 1:
        title = "Agility"
        textColor = UIColor.green
      case 2:
        title = "Intelect"
        textColor = UIColor.blue
      default:
        title = "???????"
        textColor = UIColor.white
      }
      
      headerView.titleLabel.text = title
      headerView.titleLabel.textColor = textColor
      reusableView = headerView
      //headerView.imageView.image = UIImage(named: )

    }
    return reusableView
  }
}
