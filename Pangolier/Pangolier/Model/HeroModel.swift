//
//  Hero.swift
//  Pangolier
//
//  Created by Homac on 5/16/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import Alamofire

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
    for hero in allHero where hero.id == id {
      return hero
    }
    return nil
  }

  class func getSortHeroesWithAttributes(heroes: [HeroModel]) -> [[HeroModel]] {
    let sortedHeroes = heroes.sorted(by: { $0.name < $1.name })
    let str = sortedHeroes.filter { $0.primaryAttr == "str" }
    let agi = sortedHeroes.filter { $0.primaryAttr == "agi" }
    let int = sortedHeroes.filter { $0.primaryAttr == "int" }
    return [str, agi, int]
  }

  class func getHeroes(completion: @escaping (_ heroesArray: [HeroModel]) -> Void) {

    Alamofire.request("https://api.opendota.com/api/heroes").responseJSON { response in
      do {
        guard let data = response.data else { return }
        let heroes = try JSONDecoder().decode([HeroModel].self, from: data)

        DispatchQueue.main.async {
          completion(heroes)
        }
      } catch {}

    }
  }
}
