//
//  MainViewController.swift
//  Pangolier
//
//  Created by Homac on 5/21/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseAuth

class LoginViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    GIDSignIn.sharedInstance().delegate = self
    GIDSignIn.sharedInstance().uiDelegate = self
    
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    GIDSignIn.sharedInstance().signIn()
  }
}

extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate {

  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    guard error == nil else {
      dismiss(animated: true)
      return
    }

    guard let authentication = user.authentication else { return }
    let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                   accessToken: authentication.accessToken)

    Auth.auth().signInAndRetrieveData(with: credential) { (user, _) in
      print(user)
    }

    self.dismiss(animated: true)
  }
}
