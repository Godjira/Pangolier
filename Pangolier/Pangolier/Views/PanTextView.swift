//
//  TextViewWithHeroesAndItems.swift
//  Pangolier
//
//  Created by Homac on 6/13/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import Foundation
import UIKit

class PanTextView: UITextView {
  
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
    let attrString = NSMutableAttributedString()
    let textAttachment = NSTextAttachmentImageWithName()
    textAttachment.image = UIImage(named: image_name)
    textAttachment.imageTitle = image_name
    
    let oldWidth = textAttachment.image?.size.width
    
    let scaleFactor = oldWidth! / (self.frame.size.width - 20);
    textAttachment.image = UIImage(cgImage: (textAttachment.image?.cgImage)!)
    
    let attrStringWithImage = NSAttributedString(attachment: textAttachment)
    attrString.append(self.attributedText)
    attrString.append(attrStringWithImage)
    self.attributedText = attrString
  }
  
  //MARK: setPlainText ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
  func setPlainStringWithImage(plain_string: String) -> NSAttributedString {
    func matches(for regex: String, in text: String) -> [String] {
      do {
        var heroes: [String] = []
        let regex = try NSRegularExpression(pattern: regex)
        regex.enumerateMatches(in: plain_string, options: [], range: NSMakeRange(0, plain_string.utf16.count)) { result, flags, stop in
          if let r = result?.range(at: 1), let range = Range(r, in: plain_string) {
            heroes.append(String(plain_string[range]))
          }
        }
        
        return heroes
      } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
      }
    }
    
    var plainString = plain_string
    let heroes = matches(for: "\\[img src=(.*?)\\]", in: plain_string)
    let attributedString = NSMutableAttributedString(string: plain_string)
    
    for hero in heroes {
      let range = (plainString as NSString).range(of: "[img src=\(hero)]")
      
      let textAttachment = NSTextAttachmentImageWithName()
      let image = UIImage(named: hero)
      textAttachment.imageTitle = hero
      textAttachment.image = image
      
      let attrStringWithImage = NSAttributedString(attachment: textAttachment)
      attributedString.replaceCharacters(in: range, with: attrStringWithImage)
      plainString = attributedString.string
    }
    
    return attributedString
  }
  
  
  // ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  func getPlainText() -> String {
    var count = 0
    self.attributedText.enumerateAttribute(.attachment, in : NSMakeRange(0, self.attributedText.length), options: [], using: { attribute, range, _ in
      if let attachment = attribute as? NSTextAttachment, attachment.image != nil {
        count = count + 1
      }
    })
    
    var attributedString2 = NSMutableAttributedString(attributedString: self.attributedText)
    
    for _ in 0..<count {
      let attributedString = NSMutableAttributedString(attributedString: attributedString2)
      var count = 0
      attributedString.enumerateAttribute(.attachment, in : NSMakeRange(0, attributedString.length), options: [], using: { attribute, range, _ in
        if let attachment = attribute as? NSTextAttachmentImageWithName,
          let imageTitle = attachment.imageTitle {
          let str = "[img src=\(imageTitle)]"
          
          if count == 0 {
            attributedString.beginEditing()
            attributedString.replaceCharacters(in: range, with: NSAttributedString(string : str))
            attributedString.endEditing()
            attributedString2 = attributedString
          }else{
            return
          }
          count = count + 1
        }
      })
    }
    
    return attributedString2.string
  }
  
}

class NSTextAttachmentImageWithName: NSTextAttachment {
  
  var imageSrc: String?
  var imageTitle: String?
  
}


