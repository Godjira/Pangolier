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
  var user: String
  var heroesId: [Int]
  var description: String
  var dataId: String
  var rate: [String]
  
  init(with id: String, dictionary: [String : AnyObject], rateUserArray: [String]?) {
    self.id = id
    name = dictionary["name"] as! String
    user = dictionary["user"] as! String
    heroesId = dictionary["heroes"] as! [Int]
    description = dictionary["desc"] as! String
    dataId = dictionary["bunch_data_id"] as! String
    rate = rateUserArray ?? [""]
  }
  
}

import Firebase

class BunchManager {
  
  class func sendBunch(heroes: [HeroModel]) {
    let bunchId = Int(NSDate.timeIntervalSinceReferenceDate * 1000)
    let ref = Database.database().reference()
    if heroes.count > 1 {
      var heroesId: [Int] = []
      for hero in heroes {
        heroesId.append(hero.id)
      }
      for id in heroesId {
        let sendDictionary = ["name" : bunchNameTextField.text ?? "noname",
                              "user" : Auth.auth().currentUser?.uid ?? "",
                              "heroes" : heroesId,
                              "desc" : bunchDescTextView.text ?? "nodesc",
                              "bunch_data_id" : String(timeStamp)] as [String : Any]
        
        self.ref.child("bunch").child(String(id)).childByAutoId().setValue(sendDictionary)
      }
      let sendDataDictionary = ["rate" : [" "]]
      self.ref.child("bunch_data").child(String(timeStamp)).setValue(sendDataDictionary)
      navigationController?.popViewController(animated: true)
  }
  
  class func getBunchModels(fireBaseDic: [String : AnyObject], chooseHero: HeroModel) -> [BunchModel] {
    var bunchs = [BunchModel]()
    
    
    for (id, dic) in fireBaseDic{
      var bunch = BunchModel(with: id, dictionary: dic as! [String : AnyObject], rateUserArray: nil)
      bunchs.append(bunch)
    }
    
    return bunchs
  }
  
  
  class func getRate(bunch: BunchModel, completion: @escaping (_ rate: [String]) -> Void){
    let ref = Database.database().reference()
    var rateArrayUserId: [String] = []
    
    ref.child("bunch_data").child(bunch.dataId).observeSingleEvent(of: .value, with: { (snapshot) in
      
      
      if snapshot.exists() {
        let value = snapshot.value as! [String : [String]]
        rateArrayUserId = value["rate"]!
      }
      DispatchQueue.main.async {
        completion(rateArrayUserId)
      }
      
    }) { (error) in
      print(error)
    }
  }
  
  class func sendRate(bunch_with_rate bunch: BunchModel){
    let ref = Database.database().reference()
    
    let sendDataDictionary = ["rate" : bunch.rate]
    ref.child("bunch_data").child(bunch.dataId).setValue(sendDataDictionary)
    
  }
  
}
