//
//  AddGuideHeroController.swift
//  Pangolier
//
//  Created by Homac on 5/28/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DetailBunchViewController: UIViewController {
  
  var bunch: BunchModel?
  var allHeroes: [HeroModel]?
  
  @IBOutlet weak var img1: UIImageView!
  @IBOutlet weak var img2: UIImageView!
  @IBOutlet weak var img3: UIImageView!
  @IBOutlet weak var img4: UIImageView!
  @IBOutlet weak var img5: UIImageView!
  
  @IBOutlet weak var rateImage: UIImageView!
  @IBOutlet weak var rateLabel: UILabel!
  
  
  @IBOutlet weak var descriptionTextView: UIPanTextView!
  
  override func viewDidLoad() {
    descriptionTextView.attributedText = descriptionTextView.setPlainStringWithImage(plain_string: bunch!.description)
    
    self.rateLabel.text = String(self.bunch!.rate.count)
    for userId in bunch!.rate {
      if (Auth.auth().currentUser?.uid.elementsEqual(userId))!{
        rateImage.image = #imageLiteral(resourceName: "likes")
      }
    }
    
    let heroImages = [img1, img2, img3, img4, img5]
    
    var bunchHeroes: [HeroModel] = []
    for heroId in bunch!.heroesId{
      bunchHeroes.append(HeroManager.getHeroModelById(allHero: allHeroes!, id: heroId)!)
    }
    
    bunchHeroes.enumerated().forEach { index, hero in
      heroImages[index]?.image = UIImage(named: hero.name)
    }
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(DetailBunchViewController.tapLikeButton))
    rateImage.isUserInteractionEnabled = true
    rateImage.addGestureRecognizer(tap)
    
  }
  
    @objc func tapLikeButton() {
    if Auth.auth().currentUser == nil {
      return
    }
    
    for user in bunch!.rate{
      if user == Auth.auth().currentUser?.uid {
        
        if bunch!.userId == user {
          return
        }
        
        bunch!.rate.remove(at:bunch!.rate.index(of: user)!)
        BunchManager.sendRate(bunch_with_rate: bunch!)
        rateImage.image = #imageLiteral(resourceName: "like")
        self.rateLabel.text = String(self.bunch!.rate.count)
        return
      }
    }
      bunch!.rate.append((Auth.auth().currentUser?.uid)!)
      BunchManager.sendRate(bunch_with_rate: bunch!)
      rateImage.image = #imageLiteral(resourceName: "likes")
      self.rateLabel.text = String(self.bunch!.rate.count)
      return
  }
  
  
}


