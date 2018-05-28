//
//  MainViewController.swift
//  Pangolier
//
//  Created by Homac on 5/23/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UITableViewController {
  
  @IBOutlet weak var bunchHeroesLabel: UILabel!
  @IBOutlet weak var addBunchLabel: UILabel!
  
  @IBOutlet weak var bookmarksLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bunchHeroesLabel.addGusterTap(target: self, action: #selector(MainViewController.tapBunchHeroes))
    addBunchLabel.addGusterTap(target: self, action: #selector(MainViewController.tapAddBunch))
    
  }
  
  @objc func tapBunchHeroes(sender:UITapGestureRecognizer) {
    let heroesVC = storyboard?.instantiateViewController(withIdentifier: "HeroesViewController") as! HeroesViewController
    navigationController?.pushViewController(heroesVC, animated: true)
  }
  
  @objc func tapAddBunch(sender:UITapGestureRecognizer) {
    let addBunchVC = storyboard?.instantiateViewController(withIdentifier: "AddBunchHeroesViewController") as! AddBunchHeroesViewController
    navigationController?.pushViewController(addBunchVC, animated: true)
  }
  
}
