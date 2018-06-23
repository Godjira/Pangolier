//
//  ArrayDeleting.swift
//  Pangolier
//
//  Created by Homac on 5/26/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
  
  // Remove first collection element that is equal to the given `object`:
  mutating func remove(object: Element) {
    if let index = index(of: object) {
      remove(at: index)
    }
  }
}
