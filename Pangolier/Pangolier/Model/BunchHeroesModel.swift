//
//  BunchHeroesModel.swift
//  Pangolier
//
//  Created by Homac on 5/17/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation

struct BunchModel: Decodable{
  
  var id: String
  var name: String
  var userId: String
  var heroesId: [Int]
  var description: String
  var rate: [String]
  
  init(name: String, userId: String, heroesId: [Int], description: String) {
    self.id = ""
    self.name = name
    self.userId = userId
    self.heroesId = heroesId
    self.description = description
    self.rate =  [""]
  }
  
}

import Firebase

class BunchManager {
  
  class func sendBunch(bunch: BunchModel) {
    let ref = Database.database().reference()
    let bunchId = ref.childByAutoId().key
    
    let sendDictionary = ["name" : bunch.name,
                          "user" : Auth.auth().currentUser?.uid ?? "",
                          "heroes" : bunch.heroesId,
                          "desc" : bunch.description] as [String : Any]
    
    ref.child("bunch").child(bunchId).setValue(sendDictionary)
    
    for heroId in bunch.heroesId {
      ref.child("heroesBunch").child(String(heroId)).childByAutoId().setValue(bunchId)
    }
  }

//
//  class func getBunchModels(fireBaseDic: [String : AnyObject], chooseHero: HeroModel) -> [BunchModel] {
//
//    
//    return BunchModel
//  }
  
  
  class func getRate(bunch: BunchModel, completion: @escaping (_ rate: [String]) -> Void){
//   let ref = Database.database().reference()
//    var rateArrayUserId: [String] = []
//
//    ref.child("bunch_data").child(bunch.dataId).observeSingleEvent(of: .value, with: { (snapshot) in
//
//
//      if snapshot.exists() {
//        let value = snapshot.value as! [String : [String]]
//        rateArrayUserId = value["rate"]!
//      }
//      DispatchQueue.main.async {
//        completion(rateArrayUserId)
//      }
//
//    }) { (error) in
//      print(error)
//    }
//
  }
  
  class func sendRate(bunch_with_rate bunch: BunchModel){
//    let ref = Database.database().reference()
//
//    let sendDataDictionary = ["rate" : bunch.rate]
//    ref.child("bunch_data").child(bunch.dataId).setValue(sendDataDictionary)
//
  }
  
}
