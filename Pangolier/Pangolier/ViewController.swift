//
//  ViewController.swift
//  Pangolier
//
//  Created by Homac on 5/16/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    

    @IBOutlet weak var collectonView: UICollectionView!
    var heroes = [HeroModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HeroManager.getHeroes { (heroesArray) in
            self.heroes = heroesArray
            self.collectonView.reloadData()
                    }
        
    }



    //MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 3
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
        
        cell.setHeroImage(hero: heroes[indexPath.row])
        
        return cell
    }

}

