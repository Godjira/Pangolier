//
//  BunchTableViewCell.swift
//  Pangolier
//
//  Created by Homac on 5/20/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit

class BunchTableViewCell: UITableViewCell {
  

  @IBOutlet weak var hero1Image: UIImageView!
  @IBOutlet weak var hero2Image: UIImageView!
  @IBOutlet weak var hero3Image: UIImageView!
  @IBOutlet weak var hero4Image: UIImageView!
  @IBOutlet weak var hero5Image: UIImageView!

  @IBOutlet weak var bunchNameLabel: UILabel!
  
  func setImagesAndText(allHeroes: [HeroModel], choosedHero: HeroModel, bunch: BunchModel) {
    bunchNameLabel.text = bunch.name
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
    
    
  }
}
