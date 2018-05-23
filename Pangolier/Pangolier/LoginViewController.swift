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

    GIDSignIn.sharedInstance().delegate = self
    GIDSignIn.sharedInstance().uiDelegate = self

    GIDSignIn.sharedInstance().signIn()

    //Auth.auth().currentUser
  }
  
}

extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate {

  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    guard error == nil else { return }

    guard let authentication = user.authentication else { return }
    let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                   accessToken: authentication.accessToken)

    Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
      print(user)
    }
  }
}

