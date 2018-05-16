//
//  HeroCollectionViewCell.swift
//  Pangolier
//
//  Created by Homac on 5/16/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit

class HeroCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var heroImageView: UIImageView!
  
  func setHeroImage(hero: HeroModel) -> Void {
    let imageHero = UIImage(named: hero.name)
    heroImageView.image = imageHero
  }

}
