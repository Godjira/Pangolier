//
//  BunchHeroesControllerView.swift
//  Pangolier
//
//  Created by Homac on 5/17/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit

class BunchHeroesViewController: UIViewController {
  
  var hero: HeroModel!
  
  @IBOutlet weak var nameHeroTextLabel: UILabel!
  @IBOutlet weak var heroImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    heroImageView.image = UIImage(named: hero.name)
    nameHeroTextLabel.text = hero.localizedName
  }
  
  @IBAction func addBunchAction(_ sender: UIButton) {
    let addBunchVC = storyboard?.instantiateViewController(withIdentifier: "AddBunchHeroesViewController") as! AddBunchHeroesViewController
    addBunchVC.heroes.append(hero)
    
    navigationController?.pushViewController(addBunchVC, animated: true)
  }
}
