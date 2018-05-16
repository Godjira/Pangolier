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
    var groupHeroes = [[HeroModel]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get instets
        let colletctionViewLayout = self.collectonView.collectionViewLayout as! UICollectionViewFlowLayout
        colletctionViewLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10)
        
        HeroManager.getHeroes { (heroesArray) in
            self.heroes = heroesArray
            self.collectonView.reloadData()
            
            var strHeroes = [HeroModel]()
            var agiHeroes = [HeroModel]()
            var intHeroes = [HeroModel]()
            
            for hero in self.heroes {
                if hero.primaryAttr.elementsEqual("str"){
                    strHeroes.append(hero)
                } else
                if hero.primaryAttr.elementsEqual("agi"){
                    agiHeroes.append(hero)
                } else {
                    intHeroes.append(hero)
                }
            }
            self.groupHeroes.append(strHeroes)
            self.groupHeroes.append(agiHeroes)
            self.groupHeroes.append(intHeroes)
            
                    }
    }



    //MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return groupHeroes.count
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupHeroes[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
        
        cell.setHeroImage(hero: self.groupHeroes[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView = UICollectionReusableView()
        var title = ""
        var textColor = UIColor.black
        
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
            if indexPath.section == 1 {
            title = "Strange"
                textColor = UIColor.red
            } else if indexPath.section == 2 {
                title = "Agility"
                textColor = UIColor.green
            } else if indexPath.section == 3 {
                title = "Intelect"
                textColor = UIColor.blue
            }
            headerView.titleLabel.text = title
            headerView.titleLabel.textColor = textColor
            reusableView = headerView
            //headerView.imageView.image = UIImage(named: )
           
        }
        return reusableView
        
        
    }

}

