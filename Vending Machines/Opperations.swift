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
    
}

class InventoryUnarchiver {
    static func vendingInventory(fromDictionary dictionary: [String: AnyObject]) -> [String: VMItem] {
        
        var inventory: [String: VMItem] = [:]
        
        for (key, value) in dictionary {
            if let itemDictionary = value as? [String: Any], let price = itemDictionary["price"] as? Double, let quantity = itemDictionary["quantity"] as? Int {
                let item = VMItem(name: key, price: price, quantitt: quantity)
            
                inventory.updateValue(item, forKey: item.name)
            }
        }
        return inventory
    }
}

class PlistConverter {
    static func dictionary(fromFile name: String, ofType type: String) -> [String: AnyObject] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            print("Invalid Resource")
            return [String: AnyObject]()
        }
        
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
            print("Conversion Fail")
            return [String: AnyObject]()
        }
        return dictionary
    }
}
