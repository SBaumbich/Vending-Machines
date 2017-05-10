//
//  ViewController.swift
//  Vending Machines
//
//  Created by Scott Baumbich on 4/26/17.
//  Copyright © 2017 Scott Baumbich. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "vendingItem"
fileprivate let screenWidth = UIScreen.main.bounds.width

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var scrollingHeader: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    var inventory: [VMItem] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        // Create item inventory
        let itemInventory = JSONConverter.ConverterJSON()
        do {
            inventory = try InventoryUnarchiver.vendingInventory(fromArray: itemInventory)
            print(inventory[0])
        } catch {
            print(error)
        }
        
        // Configure Collection View
        setupCollectionViewCells()
        
        //Scroll label
        UIView.animate(withDuration: 8.0, delay:0, options: [.repeat], animations: {
            self.scrollingHeader.frame = CGRect(self.scrollingHeader.frame.origin.x - 1000, self.scrollingHeader.frame.origin.y - 0, self.scrollingHeader.frame.size.width, self.scrollingHeader.frame.size.height)
        }, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupCollectionViewCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 20, right: 5)
        
        let padding: CGFloat = 10
        let itemWidth = screenWidth/3 - padding
        let itemHeight = screenWidth/3 - padding
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView.collectionViewLayout = layout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFacts" {
             _ = segue.destination as? AddFundsViewController
        }
    }

    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return inventory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? VendingItemCell else { fatalError()}
        // Configure the cell
        
        let item = inventory[indexPath.row]
        cell.icon.image = item.image
        cell.name.text = item.name.uppercased()
        cell.price.text = ("$\(item.price)")
        return cell
    }
}

extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
}
