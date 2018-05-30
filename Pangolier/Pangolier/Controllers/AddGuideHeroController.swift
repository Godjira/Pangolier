//
//  AddGuideHeroController.swift
//  Pangolier
//
//  Created by Homac on 5/28/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit

class AddGuideHeroController: UIViewController {
  
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var addItemButton: UIButton!
  @IBOutlet weak var addHeroButton: UIButton!
  
  @IBAction func addItemAction(_ sender: UIButton) {
    var attrString = NSMutableAttributedString()
    let textAttachment = NSTextAttachment()
    textAttachment.image = UIImage(named: "abyssal_blade")
    
    let oldWidth = textAttachment.image?.size.width
    
    let scaleFactor = oldWidth! / (textView.frame.size.width - 10);
    textAttachment.image = UIImage(cgImage: (textAttachment.image?.cgImage)!)
 
    let attrStringWithImage = NSAttributedString(attachment: textAttachment)
    attrString.append(textView.attributedText)
    attrString.append(attrStringWithImage)
    textView.attributedText = attrString
  }
  
  @IBAction func addHeroAction(_ sender: UIButton) {
    let singleHeroesVC = storyboard?.instantiateViewController(withIdentifier: "SingleHeroesViewController") as! SingleHeroesViewController
    singleHeroesVC.delegate = self
    self.present(singleHeroesVC, animated: true, completion: nil)
  }
  
  
}

extension AddGuideHeroController: GetHeroDelegat {
  
  func didSelect(hero: HeroModel) {
    var attrString = NSMutableAttributedString()
    let textAttachment = NSTextAttachment()
    textAttachment.image = UIImage(named: hero.name)
    
    let oldWidth = textAttachment.image?.size.width
    
    let scaleFactor = oldWidth! / (textView.frame.size.width - 10);
    textAttachment.image = UIImage(cgImage: (textAttachment.image?.cgImage)!)
    
    let attrStringWithImage = NSAttributedString(attachment: textAttachment)
    attrString.append(textView.attributedText)
    attrString.append(attrStringWithImage)
    textView.attributedText = attrString
  }
  
  
  
  
}
