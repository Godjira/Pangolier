//
//  BunchHeroesModel.swift
//  Pangolier
//
//  Created by Homac on 5/17/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation

struct BunchModel: Decodable{
  

  var name: String
  var userId: String
  var heroesId: [Int]
  var description: String
  var rate: [String]
  
  init(name: String, userId: String, heroesId: [Int], description: String) {
    self.name = name as! String
    self.userId = userId as! String
    self.heroesId = heroesId
    self.description = description as! String
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


  class func getBunchModels(hero: HeroModel, completion: @escaping ((BunchModel) -> Void)) {
    
    let ref = Database.database().reference()
    ref.child("heroesBunch").child(String(hero.id)).observeSingleEvent(of: .value) { (snapshot) in
      if snapshot.exists() {
        var bunchIdArray = [String]()
        let dic = snapshot.value!as! [String : String]
        for (_, bunchId) in dic {
          bunchIdArray.append(bunchId)
        }
        for bunchId in bunchIdArray {
          
          ref.child("bunch").child(bunchId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let bunchDic = snapshot.value as! [String : AnyObject]
            let bunch = BunchModel(name: bunchDic["name"] as! String, userId: bunchDic["user"] as! String, heroesId: bunchDic["heroes"] as! [Int], description: bunchDic["desc"] as! String)
            
            
            DispatchQueue.main.async {
              completion(bunch)
            }
            
          })
          
        }
        
        
        
     
      }
    }
    
  }
  
  
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
