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
  
  //MARK: setPlainText ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
  func setPlainStringWithImage(plain_string: String) -> NSAttributedString {
    var attributedString = NSMutableAttributedString(string: "")
    
    let plainStringArray = Array(plain_string)
    let currentStringArrray = Array(imageFromAssetsStart)
    
    var index = 0
    while index < plainStringArray.count {
      if plainStringArray[index] == "[" {
        
       
    }
    
    let rString: NSAttributedString = attributedString
    return rString
  }
    
    func checkNextCharacters(indexC: Int, plainSA: [Character], currentSA: [Character]) -> Int {
      index = indexC
      let preIndex = index
      var currentIndex = 0
      while currentIndex < currentStringArrray.count {
        if plainStringArray[index] == currentStringArrray[currentIndex] {
          index = index + 1
          currentIndex = currentIndex + 1
        }
      }
      if currentIndex == currentStringArrray.count {
        while index < plainSA.count {
          if plainSA[index] == "]"{
            //add text and image
          }
          index = index + 1
        }
        
      } else {
        index = preIndex + 1
      }
      return preIndex + 1
    }
    
    func getArrayWithIndexRange(fromIndex: Int, toIndex: Int, array: [AnyObject]) -> [AnyObject] {
      var newArray = Array(array)
      newArray[fromIndex..toIndex] = []
      
    }
  
//  func addImageToAttrText(attr_string: NSMutableAttributedString) -> NSMutableAttributedString {
//
//    return
//  }
  
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


