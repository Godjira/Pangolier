//
//  BunchHeroesModel.swift
//  Pangolier
//
//  Created by Homac on 5/17/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation

struct BunchModel {
  
  var id: String
  var name: String
  var heroesId: [Int]
  var description: String
  
  init(with id: String, dictionary: [String : AnyObject]) {
    self.id = id
    name = dictionary["name"] as! String
    heroesId = dictionary["heroes"] as! [Int]
    description = dictionary["desc"] as! String
  }
  
}

class BunchManager {
  
 class func getBunchModels(fireBaseDic: [String : AnyObject], chooseHero: HeroModel) -> [BunchModel] {
    var bunchs = [BunchModel]()
    
    for (id, dic) in fireBaseDic{
      let bunch = BunchModel(with: id, dictionary: dic as! [String : AnyObject])
      bunchs.append(bunch)
  }
  
  return bunchs
  }
  
}
