//
//  GastureTapUIView.swift
//  Pangolier
//
//  Created by Homac on 5/27/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  
  func addGestureTap(target: Any?, action: Selector?) {
    let tap = UITapGestureRecognizer(target: target, action: action)
    self.isUserInteractionEnabled = true
    self.addGestureRecognizer(tap)
  }
  
}
