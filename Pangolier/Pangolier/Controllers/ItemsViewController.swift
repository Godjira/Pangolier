//
//  ItemsViewController.swift
//  Pangolier
//
//  Created by Homac on 6/1/18.
//  Copyright © 2018 pangolier. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!

  var items: [ItemModel] = []
  var delegate: GetItemDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let item = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(ItemsViewController.okItems))
    navigationItem.rightBarButtonItem = item
    self.collectionView.allowsMultipleSelection = true

    ItemManager.getItems { (items) in
      self.items = items
      self.items = ItemManager.getExistItems(items: self.items)
      self.collectionView.reloadData()
    }
  }
  
  @objc func okItems() {
    if (collectionView.indexPathsForSelectedItems?.count)! > 0 {
    let selectedItemsIndexPath = collectionView.indexPathsForSelectedItems
    var selectedItems: [ItemModel] = []
      for itemIndexPath in selectedItemsIndexPath! {
      selectedItems.append(self.items[itemIndexPath.row])
    }
    delegate?.didSelect(items: selectedItems)
      self.navigationController?.popViewController(animated: true)
  }
  }
}

extension ItemsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: "ItemOrHeroCollectionViewCell",
                           for: indexPath) as? ItemOrHeroCollectionViewCell  else { return UICollectionViewCell() }
    cell.setItemImage(item: self.items[indexPath.row])
    return cell
  }
}

 protocol GetItemDelegate {
  func didSelect(items: [ItemModel])
}
