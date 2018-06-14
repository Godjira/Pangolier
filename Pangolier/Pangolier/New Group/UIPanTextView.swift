//
//  TextViewWithHeroesAndItems.swift
//  Pangolier
//
//  Created by Homac on 6/13/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit

class UIPanTextView: UITextView {
  
  // Image of type "From Assets"
  let imageFromAssetsStart = "[img loc="
  let imageFromAssetsEnd = "]"
  
  //Image of type "From URL"
  let imageFromURLStart = "[img url="
  let imageFromURLEnd = "]"

// --- --- ---
  
  func addImageFromAssets(image_name: String){
    addImageFromAssetsToAttrString(image_name: image_name)
  }
  
  
  func addImageFromAssetsToAttrString(image_name: String){
    var attrString = NSMutableAttributedString()
    let textAttachment = NSTextAttachmentImageWithName()
    textAttachment.image = UIImage(named: image_name)
    textAttachment.imageTitle = image_name
    
    let oldWidth = textAttachment.image?.size.width
    
    let scaleFactor = oldWidth! / (self.frame.size.width - 10);
    textAttachment.image = UIImage(cgImage: (textAttachment.image?.cgImage)!)
    
    let attrStringWithImage = NSAttributedString(attachment: textAttachment)
    attrString.append(self.attributedText)
    attrString.append(attrStringWithImage)
    self.attributedText = attrString
  }
  

  
  
  
  func getPlainText() -> String {
    var plainString: String = ""
    var countRangePlus: Int = 0
    self.attributedText.enumerateAttribute(NSAttributedStringKey.attachment, in: NSRange(location: 0, length: self.attributedText.length), options: []) { (value, range, stop) in
      
      if (value is NSTextAttachment){
        let attachment: NSTextAttachment? = (value as? NSTextAttachment)
        
        
        if ((attachment?.image) != nil) {
          print("1 image attached")
          let tempAttachment = value as! NSTextAttachmentImageWithName
          let mutableAttr = self.attributedText.mutableCopy() as! NSMutableAttributedString
          //Remove the attachment
          let text = imageFromAssetsStart + tempAttachment.imageTitle! + imageFromAssetsEnd
          countRangePlus = countRangePlus + text.count
          if plainString == "" {
          mutableAttr.replaceCharacters(in: range, with: text)
          plainString = mutableAttr.string
          } else {
            let newRange = NSMakeRange(range.lowerBound + countRangePlus, range.upperBound + countRangePlus)
            plainString.replacingCharacters(in: newRange, with: text)
          }
          countRangePlus = countRangePlus + text.count
        }else{
          print("No image attched")
        }
      }
    }
    return plainString
  }
  
}

class NSTextAttachmentImageWithName: NSTextAttachment {
  
  var imageSrc: String?
  var imageTitle: String?
  
}


