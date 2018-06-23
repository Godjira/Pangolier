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
  
  init(id: String, name: String, userId: String, heroesId: [Int], description: String, rate: [String]) {
    self.id = id
    self.name = name
    self.userId = userId
    self.heroesId = heroesId
    self.description = description 
    self.rate = rate
  }
  
}

import Firebase

class BunchManager {
  
  class func sendBunch(bunch: BunchModel) {
    let ref = Database.database().reference()
    let bunchId = ref.childByAutoId().key
    var bunchIds: [String] = []
    
    for heroId in bunch.heroesId {
      let id = ref.childByAutoId().key
      ref.child("heroesBunch").child(String(heroId)).child(id).setValue(bunchId)
      bunchIds.append(id)
    }
    
    let sendDictionary = ["id" : bunchId,
                          "name" : bunch.name,
                          "user" : Auth.auth().currentUser?.uid ?? "",
                          "heroes" : bunch.heroesId,
                          "desc" : bunch.description,
                          "rate" : [bunch.userId]] as [String : Any]
    
    ref.child("bunch").child(bunchId).setValue(sendDictionary)
    
  }
  
  class func getBunchModels(hero: HeroModel, completion: @escaping ((BunchModel) -> Void)) {
    
    let ref = Database.database().reference()
    ref.child("heroesBunch").child(String(hero.id)).observeSingleEvent(of: .value) { (snapshot) in
      if snapshot.exists() {
        let dic = snapshot.value!as! [String : String]
        let bunchIdArray: [String] = dic.map{ $0.value }
        for bunchId in bunchIdArray {
          
          ref.child("bunch").child(bunchId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let bunchDic = snapshot.value as! [String : AnyObject]
            
            let bunch = BunchModel(id: bunchDic["id"] as! String,name: bunchDic["name"] as! String, userId: bunchDic["user"] as! String, heroesId: bunchDic["heroes"] as! [Int], description: bunchDic["desc"] as! String, rate: bunchDic["rate"] as! [String])
            
            
            DispatchQueue.main.async {
              completion(bunch)
            }
          })
        }
      }
    }
  }
  
  class func getAllBunchModels(hero: HeroModel, completion: @escaping (([BunchModel]) -> Void)) {
    
    let ref = Database.database().reference()
    ref.child("bunch").observeSingleEvent(of: .value) { (snapshot) in
      var tempBunchs: [BunchModel] = []
      if snapshot.exists() {
        let bunchDic = snapshot.value as! [String : [String : AnyObject]]
        for (_, dic) in bunchDic {
          let bunch = BunchModel(id: dic["id"] as! String,name: dic["name"] as! String, userId: dic["user"] as! String, heroesId: dic["heroes"] as! [Int], description: dic["desc"] as! String, rate: dic["rate"] as! [String])
          tempBunchs.append(bunch)
        }
      }
      var bunchs: [BunchModel] = []
      
      for bunch in tempBunchs {
        for id in bunch.heroesId {
          if id == hero.id {
            bunchs.append(bunch)
          }
        }
      }
      bunchs.sort(by: { $0.rate.count > $1.rate.count  })
      
      DispatchQueue.main.async {
        completion(bunchs)
      }
      
    }
  }
  
  class func sendRate(bunch_with_rate bunch: BunchModel){
    let ref = Database.database().reference()
    
    
    let sendDictionary = ["id" : bunch.id,
                          "name" : bunch.name,
                          "user" : bunch.userId,
                          "heroes" : bunch.heroesId,
                          "desc" : bunch.description,
                          "rate" : bunch.rate] as [String : Any]
    
    ref.child("bunch").child(bunch.id).setValue(sendDictionary)
    
  }
  
}
