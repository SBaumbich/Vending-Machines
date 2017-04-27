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



class ViewController: UIViewController {

    @IBOutlet var scrollingHeader: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Scroll label
        UIView.animate(withDuration: 8.0, delay:0, options: [.repeat], animations: {
            self.scrollingHeader.frame = CGRect(self.scrollingHeader.frame.origin.x - 650, self.scrollingHeader.frame.origin.y - 0, self.scrollingHeader.frame.size.width, self.scrollingHeader.frame.size.height)
        }, completion: nil)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupCollectionViewCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        let padding: CGFloat = 10
        let itemWidth = screenWidth/3 - padding
        let itemHeight = screenWidth/3 - padding
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView.collectionViewLayout = layout
    }
    
}



extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
}
