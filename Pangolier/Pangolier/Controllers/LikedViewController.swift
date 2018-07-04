//
//  LikedViewController.swift
//  Pangolier
//
//  Created by Homac on 7/1/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit

class LikedViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  var likedBunchs: [BunchModel] = []
  var allHeroes: [HeroModel]?

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    likedBunchs = [BunchModel]()

    BunchMarksManager.getLikedBunchs { (bunch) in
      self.likedBunchs.append(bunch)
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

extension LikedViewController: UITableViewDelegate, UITableViewDataSource {

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return likedBunchs.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: "BunchTableViewCell", for: indexPath) as? BunchTableViewCell else { return UITableViewCell()}
    guard let allHeroes = allHeroes else { return UITableViewCell() }
    cell.setImagesAndText(allHeroes: allHeroes, bunch: self.likedBunchs[indexPath.row])

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let detailBunchVC = storyboard?
      .instantiateViewController(withIdentifier: "DetailBunchViewController") as? DetailBunchViewController else { return }
    detailBunchVC.allHeroes = self.allHeroes
    detailBunchVC.bunch = likedBunchs[indexPath.row]
    navigationController?.pushViewController(detailBunchVC, animated: true)
  }
}
