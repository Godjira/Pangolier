//
//  Hero.swift
//  Pangolier
//
//  Created by Homac on 5/16/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation

struct HeroModel: Decodable {
  
  var id: Int
  var name: String
  var localizedName: String
  var primaryAttr: String
  var attackType: String
  var roles: [String]
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case localizedName = "localized_name"
    case primaryAttr = "primary_attr"
    case attackType = "attack_type"
    case roles
  }
  
}

class HeroManager {
  
  class func getHeroModelById(allHero: [HeroModel], id: Int) -> HeroModel? {
    for hero in allHero{
      if hero.id == id {
        return hero
      }
    }
    return nil
  }
  
  class func getSortHeroesWithAttributes(heroes: [HeroModel]) -> [[HeroModel]] {
    let sortedHeroes = heroes.sorted(by: { $0.name < $1.name })
    return Dictionary(grouping: sortedHeroes, by: { $0.primaryAttr }).map { $0.value }
  }
  
  class func getHeroes(completion: @escaping (_ heroesArray: [HeroModel]) -> Void) {
    let urlString = "https://api.opendota.com/api/heroes"
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let data = data, error  == nil else { return }
      do {
        let heroes = try JSONDecoder().decode([HeroModel].self, from: data)
        
        DispatchQueue.main.async {
          completion(heroes)
        }
      } catch let error {
        print(error)
      }
      }.resume()
  }
}
