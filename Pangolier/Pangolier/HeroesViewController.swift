//
//  HeroesViewController.swift
//  Pangolier
//
//  Created by Homac on 5/16/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import UIKit

class HeroesViewController: UIViewController {
  
  @IBOutlet weak var collectonView: UICollectionView!
  var heroes = [HeroModel]()
  var groupHeroes: [[HeroModel]] = [[]]
  var selectHeroesIndex: [IndexPath] = []
  
  weak var delegate: GetHeroDelegat?

  let sections: [(title: String, color: UIColor)] = [("Strange", .red),
                                                     ("Agility", .green),
                                                     ("Intelect", .blue)]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    if delegate != nil {
      let item = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(HeroesViewController.saveHeroBunchAction))
      navigationItem.rightBarButtonItem = item
      collectonView.allowsMultipleSelection = true
    }
    
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
  
  @objc func saveHeroBunchAction() {
    print("tap save")
    var saveHeroes: [HeroModel] = []
    for indexPath in selectHeroesIndex{
      saveHeroes.append(self.groupHeroes[indexPath.section][indexPath.row])
    }
    self.delegate?.didSelect(heroes: saveHeroes)
    navigationController?.popViewController(animated: true)
  }

}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
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
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    if let delegate = delegate {
      if selectHeroesIndex.count < 5 {
        selectHeroesIndex.append(indexPath)
        let cell = collectonView.cellForItem(at: indexPath) as! HeroCollectionViewCell
        UIView.animate(withDuration: 0.2) {
          cell.selectView.alpha = 0.3
        }
        
      } else {
        let cell = collectonView.cellForItem(at: indexPath) as! HeroCollectionViewCell
        UIView.animate(withDuration: 0.4) {
          cell.selectView.alpha = 0.0
        }
        collectonView.deselectItem(at: indexPath, animated: true)
      }
    } else {
      let selectedHero = groupHeroes[indexPath.section][indexPath.row]
      let bunchHeroesViewController = storyboard?.instantiateViewController(withIdentifier: "BunchHeroesViewController") as! BunchHeroesViewController
      bunchHeroesViewController.hero = selectedHero
      bunchHeroesViewController.allHeroes = self.heroes
      navigationController?.pushViewController(bunchHeroesViewController, animated: true)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    var i = 0
    if let delegate = delegate {
      for index in selectHeroesIndex {
        if index == indexPath {
          selectHeroesIndex.remove(at: i)
          let cell = collectonView.cellForItem(at: indexPath) as! HeroCollectionViewCell
          UIView.animate(withDuration: 0.4) {
            cell.selectView.alpha = 0.0
          }
        }
        i = i + 1
      }
    }
  }
  
}
