//
//  SingleHeroesViewController.swift
//  Pangolier
//
//  Created by Homac on 5/29/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import UIKit

class SingleHeroesViewController: BaseHeroesViewController {
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let selectedHero = groupHeroes[indexPath.section][indexPath.row]
    let heroVC = storyboard?.instantiateViewController(withIdentifier: "HeroViewController") as! HeroViewController
    heroVC.hero = selectedHero
    heroVC.allHeroes = self.heroes
    navigationController?.pushViewController(heroVC, animated: true)
  }
  
  
}


