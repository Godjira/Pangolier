//
//  ItemModel.swift
//  Pangolier
//
//  Created by Homac on 6/1/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit

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

    URLSession.shared.dataTask(with: url) { (data, _, error) in
      guard let data = data, error  == nil else { return }

      do {
        let dataItems = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] ?? [: ]
        let tempDic = dataItems["result"] as? [String: AnyObject] ?? [:]
        let arrayItems = tempDic["items"] as? [AnyObject] ?? []
        var items: [ItemModel] = []
        for item in arrayItems {
          let nativeItem = ItemModel.init(id: item["id"] as? Int ?? 0,
                                          name: item["name"] as? String ?? "",
                                          cost: item["cost"] as? Int ?? 0,
                                          secretShop: item["secret_shop"] as? Int ?? 0,
                                          sideShop: item["side_shop"] as? Int ?? 0,
                                          recipe: item["recipe"] as? Int ?? 0,
                                          localizedName: item["localized_name"] as? String ?? "")
          items.append(nativeItem)
        }
        DispatchQueue.main.async {
          completion(items)
        }
      } catch let error {
        print(error)
      }
      }.resume()
  }

  class func getExistItems(items: [ItemModel]) -> [ItemModel] {
    var mutItems = [ItemModel]()
    for var item in items {
      let itemName = item.name.replacingOccurrences(of: "item_", with: "")
      if UIImage(named: itemName) != nil {
        item.name = itemName
        mutItems.append(item)
      }
    }
    return mutItems
  }
}
