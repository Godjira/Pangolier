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
  @IBOutlet weak var nameHeroTextLabel: UILabel!
  @IBOutlet weak var heroImageView: UIImageView!
  
  var width = CGFloat(integerLiteral: 0)
  var height = CGFloat(integerLiteral: 0)
  
  var hero: HeroModel!
  var allHeroes: [HeroModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    heroImageView.image = UIImage(named: hero.name)
    nameHeroTextLabel.text = hero.localizedName
    tabBar.delegate = self
    tabBar.selectedItem = gideTabBarItem
    
    let bunchVC = storyboard?.instantiateViewController(withIdentifier: "BunchHeroesViewController") as! BunchHeroesViewController
    bunchVC.hero = self.hero
    bunchVC.allHeroes = self.allHeroes
    
    let guideVC = storyboard?.instantiateViewController(withIdentifier: "GideViewController")
    
    let bounds = UIScreen.main.bounds
    width = bounds.size.width
    height = bounds.size.height
    
    scrollView.contentSize = CGSize(width: 2 * width, height: height)
    
    let viewControllers = [guideVC, bunchVC]

    
    var idx: Int = 0
    
    for viewController in viewControllers {
      
      addChildViewController(viewController!)
      let originX = CGFloat(idx) * width
      viewController?.view.frame = CGRect(origin: CGPoint(x: originX, y: 0), size: CGSize(width: width, height: height))
      scrollView.addSubview((viewController?.view)!)
      viewController?.didMove(toParentViewController: self)
      idx = idx + 1
    }
  }
  
  @IBAction func addAction(_ sender: Any) {
    switch tabBar.selectedItem {
    case gideTabBarItem:
      let addGuideVC = storyboard?.instantiateViewController(withIdentifier: "AddGuideHeroController")
      navigationController?.pushViewController(addGuideVC!, animated: true)
    case bunchTabBarItem:
      let addBunchVC = storyboard?.instantiateViewController(withIdentifier: "AddBunchHeroesViewController")
      navigationController?.pushViewController(addBunchVC!, animated: true)
    default:
      let addGuideVC = storyboard?.instantiateViewController(withIdentifier: "AddGuideHeroController")
      navigationController?.pushViewController(addGuideVC!, animated: true)
    }
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
      self.scrollView.setContentOffset(CGPoint(x: width, y: 0), animated: true)
    }
  }
  
}
