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

  func setImagesAndText(allHeroes: [HeroModel], bunch: BunchModel) {
    bunchNameLabel.text = bunch.name
    cellBunch = bunch
    self.rateLabel.text = String(self.cellBunch.rate.count)
    for userId in cellBunch.rate {
      if let uid = Auth.auth().currentUser?.uid, uid == userId {
        buttonLike.image = #imageLiteral(resourceName: "likes")
        break
      } else {
        buttonLike.image = #imageLiteral(resourceName: "like")
      }
    }

    let heroImages = [hero1Image, hero2Image, hero3Image, hero4Image, hero5Image]
    //delete chosed hero
    var bunchHeroes: [HeroModel] = []
    for heroId in bunch.heroesId {
      bunchHeroes.append(HeroManager.getHeroModelById(allHero: allHeroes, id: heroId)!)
    }

    bunchHeroes.enumerated().forEach { index, hero in
      heroImages[index]?.image = UIImage(named: hero.name)
    }

    let tap = UITapGestureRecognizer(target: self, action: #selector(BunchTableViewCell.tapLikeButton))
    buttonLike.isUserInteractionEnabled = true
    buttonLike.addGestureRecognizer(tap)

  }

  @objc func tapLikeButton(navigation: UINavigationController) {
    guard Auth.auth().currentUser != nil else {
      let loginVC = LoginViewController()
      loginVC.modalTransitionStyle = .crossDissolve
      loginVC.modalPresentationStyle = .overCurrentContext
      UIApplication.shared.keyWindow?.rootViewController?.present(loginVC, animated: true)
      return
    }
    for user in cellBunch.rate {
      if user == Auth.auth().currentUser?.uid {

        if cellBunch.userId == user {
          return
        }

        cellBunch.rate.remove(at: cellBunch.rate.index(of: user)!)
        BunchManager.sendRate(bunch_with_rate: cellBunch)
        buttonLike.image = #imageLiteral(resourceName: "like")
        BunchMarksManager.disLikedBunch(bunch: cellBunch)
        self.rateLabel.text = String(self.cellBunch.rate.count)
        return
      }
    }

    cellBunch.rate.append((Auth.auth().currentUser?.uid)!)
    BunchManager.sendRate(bunch_with_rate: cellBunch)
    BunchMarksManager.likedBunch(bunch: cellBunch, bunchId: cellBunch.id)
    buttonLike.image = #imageLiteral(resourceName: "likes")
    self.rateLabel.text = String(self.cellBunch.rate.count)
    return
  }
}
