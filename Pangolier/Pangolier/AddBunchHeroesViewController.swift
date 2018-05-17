//
//  AddBunchHeroesControllerView.swift
//  Pangolier
//
//  Created by Homac on 5/17/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit

class AddBunchHeroesViewController: UIViewController {
  
  var heroes: [HeroModel] = []
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  

  
  @IBAction func addHeroAction(_ sender: Any) {
    print(heroes)
    if heroes.count<5 {
    let heroesVC = storyboard?.instantiateViewController(withIdentifier: "HeroesViewController") as! HeroesViewController
    heroesVC.delegate = self
    heroesVC.iNeed = .AddBunchViewController
    navigationController?.pushViewController(heroesVC, animated: true)
    }
  }
  
  
}

extension AddBunchHeroesViewController: UICollectionViewDelegate, UICollectionViewDataSource, GetHeroDelegat{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return heroes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
    
    cell.setHeroImage(hero: heroes[indexPath.row])
    
    return cell
  }
  
  func didSelect(hero: HeroModel) {
    heroes.append(hero)
    collectionView.reloadData()
  }
  
}

protocol GetHeroDelegat: class {
  
  func didSelect(hero: HeroModel)
  
}
