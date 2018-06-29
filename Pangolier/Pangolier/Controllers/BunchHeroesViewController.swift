//
//  BunchHeroesControllerView.swift
//  Pangolier
//
//  Created by Homac on 5/17/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class BunchHeroesViewController: UIViewController {
  
  var hero: HeroModel!
  var allHeroes: [HeroModel] = []
  var ref: DatabaseReference!
  var bunchs: [BunchModel] = []
  
  @IBOutlet weak var tableView: UITableView!

  override func viewWillAppear(_ animated: Bool) {
    self.bunchs = []
    BunchManager.getBunchModels(hero: hero) { (bunch) in
      self.bunchs.append(bunch)
      self.tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func addBunchAction(_ sender: UIButton) {
    guard let addBunchVC = storyboard?
      .instantiateViewController(withIdentifier: "AddBunchHeroesViewController") as? AddBunchHeroesViewController else { return }

    addBunchVC.heroes.append(hero)
    navigationController?.pushViewController(addBunchVC, animated: true)
  }
}

extension BunchHeroesViewController: UITableViewDelegate, UITableViewDataSource {

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bunchs.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: "BunchTableViewCell", for: indexPath) as? BunchTableViewCell else { return UITableViewCell()}
    cell.setImagesAndText(allHeroes: self.allHeroes, bunch: self.bunchs[indexPath.row], controller: self)
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let detailBunchVC = storyboard?
      .instantiateViewController(withIdentifier: "DetailBunchViewController") as? DetailBunchViewController else { return }
    detailBunchVC.allHeroes = self.allHeroes
    detailBunchVC.bunch = bunchs[indexPath.row]
    navigationController?.pushViewController(detailBunchVC, animated: true)
  }

}
