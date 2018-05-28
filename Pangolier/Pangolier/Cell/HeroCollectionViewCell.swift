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
  @IBOutlet weak var selectView: UIView!
  
  override var isSelected: Bool {
    didSet {
      UIView.animate(withDuration: 0.4) {
        self.selectView.alpha = self.isSelected ? 0.3 : 0.0
      }
    }
  }
  
  func setHeroImage(hero: HeroModel) {
    let imageHero = UIImage(named: hero.name)
    heroImageView.image = imageHero
  }

}
