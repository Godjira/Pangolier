//
//  HeroCollectionViewCell.swift
//  Pangolier
//
//  Created by Homac on 5/16/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit

class ItemOrHeroCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var itemOrHeroImageView: UIImageView!
  @IBOutlet weak var selectView: UIView!
  var isNeedDelete = false
  
  override var isSelected: Bool {
    didSet {
      if selectView != nil {
        UIView.animate(withDuration: 0.4) {
          self.selectView.alpha = self.isSelected ? 0.3 : 0.0
        }
      }
    }
  }
  
  func setHeroImage(hero: HeroModel) {
    let imageHero = UIImage(named: hero.name)
    itemOrHeroImageView.image = imageHero
  }
  
  func setItemImage(item: ItemModel) {
    let imageItem = UIImage(named: item.name)
    itemOrHeroImageView.image = imageItem
    itemOrHeroImageView.contentMode = .scaleAspectFit
  }
  
}
