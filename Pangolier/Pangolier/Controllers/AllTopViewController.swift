//
//  AllTopViewController.swift
//  Pangolier
//
//  Created by Homac on 7/3/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit

class AllTopViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  var allHeroes: [HeroModel]?
  var topBunchs: [BunchModel] = []

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    topBunchs = [BunchModel]()

    AllTopManager.getAllBunchModels { (bunch) in
      self.topBunchs = bunch
      self.tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    HeroManager.getHeroes { (heroes) in
      self.allHeroes = heroes
      self.tableView.reloadData()
    }
  }

}

extension AllTopViewController: UITableViewDelegate, UITableViewDataSource {

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return topBunchs.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: "BunchTableViewCell", for: indexPath) as? BunchTableViewCell else { return UITableViewCell()}
    guard let allHeroes = allHeroes else { return UITableViewCell() }
    cell.setImagesAndText(allHeroes: allHeroes, bunch: topBunchs[indexPath.row])

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let detailBunchVC = storyboard?
      .instantiateViewController(withIdentifier: "DetailBunchViewController") as? DetailBunchViewController else { return }
    detailBunchVC.allHeroes = self.allHeroes
    detailBunchVC.bunch = topBunchs[indexPath.row]
    navigationController?.pushViewController(detailBunchVC, animated: true)
  }
}
