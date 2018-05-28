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
  
  @IBAction func addItemAction(_ sender: Any) {
    var attrString = NSMutableAttributedString()
    let textAttachment = NSTextAttachment()
    textAttachment.image = UIImage(named: "abyssal_blade")
    
    let oldWidth = textAttachment.image?.size.width
    
    //I'm subtracting 10px to make the image display nicely, accounting
    //for the padding inside the textView
    let scaleFactor = oldWidth! / (textView.frame.size.width - 10);
    textAttachment.image = UIImage(cgImage: (textAttachment.image?.cgImage)!)
 
    let attrStringWithImage = NSAttributedString(attachment: textAttachment)
    attrString.append(textView.attributedText)
    attrString.append(attrStringWithImage)
    textView.attributedText = attrString
  }
  
}
