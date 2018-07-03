//
//  AllTopManager.swift
//  Pangolier
//
//  Created by Homac on 7/3/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import Firebase

class AllTopManager {

  class func getAllBunchModels(completion: @escaping (([BunchModel]) -> Void)) {

    let ref = Database.database().reference()

    ref.child("bunch").observeSingleEvent(of: .value) { (snapshot) in
      var tempBunchs: [BunchModel] = []
      if snapshot.exists() {
        guard let bunchDic = snapshot.value as? [String: [String: AnyObject]] else { return }

        for (_, dic) in bunchDic {
          let bunch = BunchModel(id: dic["id"] as? String ?? "",
                                 name: dic["name"] as? String ?? "",
                                 userId: dic["user"] as? String ?? "",
                                 heroesId: dic["heroes"] as? [Int] ?? [],
                                 description: dic["desc"] as? String ?? "",
                                 rate: dic["rate"] as? [String] ?? [""])

          tempBunchs.append(bunch)
        }
        tempBunchs.sort(by: { $0.rate.count > $1.rate.count  })
        while tempBunchs.count > 10 {
          tempBunchs.removeLast()
        }
        let bunch = tempBunchs

        DispatchQueue.main.async {
          completion(bunch)
        }

      }
    }
  }
}
