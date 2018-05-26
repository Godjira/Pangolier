//
//  BunchTableViewCell.swift
//  Pangolier
//
//  Created by Homac on 5/20/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class BunchTableViewCell: UITableViewCell {
  
  var cellBunch: BunchModel!
  
  @IBOutlet weak var hero1Image: UIImageView!
  @IBOutlet weak var hero2Image: UIImageView!
  @IBOutlet weak var hero3Image: UIImageView!
  @IBOutlet weak var hero4Image: UIImageView!
  @IBOutlet weak var hero5Image: UIImageView!
  @IBOutlet weak var bunchNameLabel: UILabel!
  @IBOutlet weak var rateLabel: UILabel!
  @IBOutlet weak var buttonLike: UIImageView!
  
  
  func setImagesAndText(allHeroes: [HeroModel], choosedHero: HeroModel, bunch: BunchModel) {
    bunchNameLabel.text = bunch.name
    cellBunch = bunch
    cellBunch.rate = BunchManager.getRate(bunch: bunch)
    
    
    let heroImages = [hero1Image, hero2Image, hero3Image, hero4Image, hero5Image]
    //delete chosed hero
    var bunchHeroes: [HeroModel] = []
    for heroId in bunch.heroesId{
      bunchHeroes.append(HeroManager.getHeroModelById(allHero: allHeroes, id: heroId)!)
    }
    
    var i = 0
    for hero in bunchHeroes{
      heroImages[i]?.image = UIImage(named: hero.name)
      i = i + 1
    }
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(BunchTableViewCell.tapLikeButton))
    buttonLike.isUserInteractionEnabled = true
    buttonLike.addGestureRecognizer(tap)
    rateLabel.text = String(cellBunch.rate.count)
    
  }
  
  @objc func tapLikeButton() {
    for user in cellBunch.rate{
      if user == Auth.auth().currentUser?.uid {
        return
      } else {
        print("like bunch")
        return
      }
    }
    print("That imposible")
  }
  
}
