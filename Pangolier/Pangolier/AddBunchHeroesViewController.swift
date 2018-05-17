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
  
  @IBOutlet weak var firstHeroImageView: UIImageView!
  @IBOutlet weak var hero2ImageView: UIImageView!
  @IBOutlet weak var hero3ImageView: UIImageView!
  @IBOutlet weak var hero4ImageView: UIImageView!
  @IBOutlet weak var hero5ImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    firstHeroImageView.image = UIImage(named: (heroes.first?.name)!)
    
  }
  
  
}
