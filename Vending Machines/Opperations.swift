//
//  Opperations.swift
//  Vending Machines
//
//  Created by Scott Baumbich on 4/27/17.
//  Copyright © 2017 Scott Baumbich. All rights reserved.
//


import Foundation
import UIKit

struct VMItem {
    var name: String
    var price: Double
    var quantitt: Int
    var servingSize: String?
    var amountPerServing : String?
    var calories: Int?
    var totalFat : (String, Int)?
    var saturatedFat : (String, Int)?
    var transFat : (String, Int?)?
    var sodium : (String, Int)?
    var totalCarbohydrate : (String, Int)?
    var dietaryFiber : (String, Int)?
    var sugars: (String, Int?)?
    var protein: (String, Int?)?
    var image: UIImage {
        if let image = UIImage(named: self.name) {
            return image
        } else {
            return #imageLiteral(resourceName: "default")
        }
    }
}

class InventoryUnarchiver {
    static func vendingInventory(fromArray array: [[String: AnyObject]]) -> [VMItem] {
        
        
        return inventory
    }
}

class JSONConverter {
    static func ConverterJSON() -> [[String: AnyObject]] {
        
        /* Path for JSON files bundled with the Playground */
        let pathForVendingItemJSON = Bundle.main.path(forResource: "VendingItemData", ofType: "json")
        
        /* Raw JSON data (...simliar to the format you might receive from the network) */
        let rawVendingItemJSON = NSData(contentsOfFile: pathForVendingItemJSON!)
        
        /* Parse the data into usable form */
        let parsedVendingItemJSON = try! JSONSerialization.jsonObject(with: rawVendingItemJSON! as Data, options: .allowFragments) as! NSArray
        
        return parsedVendingItemJSON as! [[String : AnyObject]]
    }
    
}













