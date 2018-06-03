//
//  ItemModel.swift
//  Pangolier
//
//  Created by Homac on 6/1/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation

struct ItemModel {
  
  var id: Int
  var name: String
  var cost: Int
  var secretShop: Int
  var sideShop: Int
  var recipe: Int
  var localizedName: String
  

}

class ItemManager {
  
  class func getItems (completion: @escaping (_ heroesArray: [ItemModel]) -> Void) {
    let stringUrl = "https://api.steampowered.com/IEconDOTA2_570/GetGameItems/v0001/?key=A843FF8448F15281828160693AA02892&language=ru_RU"
    guard let url = URL(string: stringUrl) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let data = data, error  == nil else { return }
      
      
      
      do {
//        let items = try JSONDecoder().decode(DataItemModel.self, from: data)
        
        DispatchQueue.main.async {
          completion([ItemModel]())
        }
      } catch let error {
        print(error)
      }
      }.resume()
  }
}
