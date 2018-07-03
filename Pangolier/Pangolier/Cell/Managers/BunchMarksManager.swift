//
//  BunchMarksManager.swift
//  Pangolier
//
//  Created by Homac on 7/1/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import Firebase

class BunchMarksManager {

  class func likedBunch(bunch: BunchModel) {

    let ref = Database.database().reference()
    guard let uid = Auth.auth().currentUser?.uid else { return }

    ref.child("bunchMarks").child(uid).observeSingleEvent(of: .value) { (snapshot) in
      if snapshot.exists() {

        guard var likedBunchs = snapshot.value as? [String] else { return }
        for bunchId in likedBunchs where bunchId == bunch.id {
          return
        }
        likedBunchs.append(bunch.id)
        ref.child("bunchMarks").child(uid).setValue(likedBunchs)
      } else {
        let likedsBuch = [bunch.id]
        ref.child("bunchMarks").child(uid).setValue(likedsBuch)
      }
    }
  }

  class func disLikedBunch(bunch: BunchModel) {

    let ref = Database.database().reference()
    guard let uid = Auth.auth().currentUser?.uid else { return }

    ref.child("bunchMarks").child(uid).observeSingleEvent(of: .value) { (snapshot) in
      if snapshot.exists() {

        guard var likedBunchs = snapshot.value as? [String] else { return }
        for bunchId in likedBunchs where bunchId == bunch.id {
          likedBunchs.remove(object: bunchId)
        }
        ref.child("bunchMarks").child(uid).setValue(likedBunchs)
      }
    }
  }

  class func getLikedBunchs(completion:  @escaping ((BunchModel) -> Void)) {

    let ref = Database.database().reference()
    guard let uid = Auth.auth().currentUser?.uid else { return }

    ref.child("bunchMarks").child(uid).observeSingleEvent(of: .value) { (snapshot) in
      if snapshot.exists() {

        guard let likedBunchs = snapshot.value as? [String] else { return }
        for bunchId in likedBunchs {
          ref.child("bunch").child(bunchId).observeSingleEvent(of: .value, with: { (bunchSnapshot) in
            if bunchSnapshot.exists() {

              guard let dic = bunchSnapshot.value as? [String: AnyObject] else { return }
              let bunch = BunchModel(id: dic["id"] as? String ?? "",
                                     name: dic["name"] as? String ?? "",
                                     userId: dic["user"] as? String ?? "",
                                     heroesId: dic["heroes"] as? [Int] ?? [],
                                     description: dic["desc"] as? String ?? "",
                                     rate: dic["rate"] as? [String] ?? [""])

              DispatchQueue.main.async {
                completion(bunch)
              }

            }
          })
        }
      }
    }
  }

}
