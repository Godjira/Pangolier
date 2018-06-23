//
//  HeroViewController.swift
//  Pangolier
//
//  Created by Homac on 5/28/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit

class HeroViewController: UIViewController {
  
  @IBOutlet weak var tabBar: UITabBar!
  @IBOutlet weak var gideTabBarItem: UITabBarItem!
  @IBOutlet weak var bunchTabBarItem: UITabBarItem!
  @IBOutlet weak var scrollView: UIScrollView!
  
  var hero: HeroModel!
  var allHeroes: [HeroModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tabBar.delegate = self
    tabBar.selectedItem = gideTabBarItem
    
    setupViewControllers()
  }
  
  func setupViewControllers() {
    let bunchVC = storyboard?.instantiateViewController(withIdentifier: "BunchHeroesViewController") as! BunchHeroesViewController
    bunchVC.hero = self.hero
    bunchVC.allHeroes = self.allHeroes
    
    let topVC = storyboard?.instantiateViewController(withIdentifier: "TopHeroBunchsViewController") as! TopHeroBunchsViewController
    topVC.hero = self.hero
    topVC.allHeroes = self.allHeroes
    
    let bounds = UIScreen.main.bounds
    let width = bounds.size.width
    let height = bounds.size.height
    
    scrollView.contentSize = CGSize(width: 2 * width, height: height)
    
    let viewControllers = [bunchVC, topVC]
    
    var idx: Int = 0
    
    for viewController in viewControllers {
      addChildViewController(viewController)
      let originX = CGFloat(idx) * width
      viewController.view.frame = CGRect(origin: CGPoint(x: originX, y: 0), size: CGSize(width: width, height: height))
      scrollView.addSubview(viewController.view)
      viewController.didMove(toParentViewController: self)
      idx = idx + 1
    }
  }
  
  @IBAction func addAction(_ sender: Any) {
    let addBunchVC = storyboard?.instantiateViewController(withIdentifier: "AddBunchHeroesViewController")
    navigationController?.pushViewController(addBunchVC!, animated: true)
  }
}

extension HeroViewController: UITabBarDelegate, UIScrollViewDelegate {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
    let selectedItem = tabBar.items![index]
    tabBar.selectedItem = selectedItem
  }
  
  
  func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    if item == gideTabBarItem {
      self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    if item == bunchTabBarItem {
      self.scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.size.width, y: 0), animated: true)
    }
  }
  
}
