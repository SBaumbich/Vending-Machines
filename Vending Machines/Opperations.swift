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
    var quantity: Int
    var servingSize: String?
    var amountPerServing : String?
    var calories: Int?
    var totalFat : (String, Int)?
    var saturatedFat : (String, Int)?
    var transFat : (String, String)?
    var sodium : (String, Int)?
    var carbs : (String, Int)?
    var dietaryFiber : (String, Int)?
    var sugars: (String, String)?
    var protein: (String, String)?
    var image: UIImage?
}

enum ParsingError: Error {
    case missing(String)
    case invalid(String, Any)
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


class InventoryUnarchiver {
    static func vendingInventory(fromArray array: [[String: AnyObject]]) throws -> [VMItem] {
        
        var inventory : [VMItem] = []
        for item in array {
            guard let vmDict = item["item"] as? [String: Any]else {
                throw ParsingError.invalid("Dict", false)
            }
            guard let name = vmDict["name"] as? String else {
                throw ParsingError.missing("Missing item name")
            }
            guard let price = vmDict["price"] as? Double else {
                throw ParsingError.missing("Missing item price")
            }
            guard let quantity = vmDict["quantity"] as? Int else {
                throw ParsingError.missing("Missing item quantity")
            }
            guard let nutritionFacts = vmDict["nutrition facts"] as? [String : Any] else {
                throw ParsingError.missing("Missing item serving size")
            }
            guard let servingSize = nutritionFacts["serving size"] as? String else {
                throw ParsingError.invalid("Dict", false)
            }
            guard let amountPerServing = nutritionFacts["amount per serving"] as? String else {
                throw ParsingError.missing("Missing item amount per serving")
            }
            guard let calories = nutritionFacts["calories"] as? Int else {
                throw ParsingError.missing("Missing item calories")
            }
            guard let totalFatDict = nutritionFacts["total fat"] as? [String : Any], let totalFat = (totalFatDict["unit amount"], totalFatDict["% daily value"]) as? (String, Int) else {
                throw ParsingError.missing("Missing item total fat")
            }
            guard let totalSaturatedFatDict = nutritionFacts["saturated fat"] as? [String : Any], let totalSaturatedFat = (totalSaturatedFatDict["unit amount"], totalSaturatedFatDict["% daily value"]) as? (String, Int) else {
                throw ParsingError.missing("Missing item total saturated fat")
            }
            guard let totalTransFatDict = nutritionFacts["trans fat"] as? [String : Any], let totalTransFat = (totalTransFatDict["unit amount"], totalTransFatDict["% daily value"]) as? (String, String) else {
                throw ParsingError.missing("Missing item total trans fat")
            }
            guard let totalSodiumDict = nutritionFacts["sodium"] as? [String : Any], let totalSodium = (totalSodiumDict["unit amount"], totalSodiumDict["% daily value"]) as? (String, Int) else {
                throw ParsingError.missing("Missing item total sodium")
            }
            guard let totalCarbsDict = nutritionFacts["total carbohydrate"] as? [String : Any], let totalCarbs = (totalCarbsDict["unit amount"], totalCarbsDict["% daily value"]) as? (String, Int) else {
                throw ParsingError.missing("Missing item total carbs")
            }
            guard let totalDietaryFiberDict = nutritionFacts["dietary fiber"] as? [String : Any], let totalDietaryFiber = (totalDietaryFiberDict["unit amount"], totalDietaryFiberDict["% daily value"]) as? (String, Int) else {
                throw ParsingError.missing("Missing item total dietary fiber")
            }
            guard let totalSugarsDict = nutritionFacts["sugars"] as? [String : Any], let totalSugars = (totalSugarsDict["unit amount"], totalSugarsDict["% daily value"]) as? (String, String) else {
                throw ParsingError.missing("Missing item total sugar")
            }
            guard let totalProteinDict = nutritionFacts["protein"] as? [String : Any], let totalProtein = (totalProteinDict["unit amount"], totalProteinDict["% daily value"]) as? (String, String) else {
                throw ParsingError.missing("Missing item total sugar")
            }
            var image = #imageLiteral(resourceName: "default")
        
            if let itemImage = UIImage(named: name) {
                image = itemImage
            } else {
                print("image error")
            }
            
            
            let newItem = VMItem(name: name, price: price, quantity: quantity, servingSize: servingSize, amountPerServing: amountPerServing, calories: calories, totalFat: totalFat, saturatedFat: totalSaturatedFat, transFat: totalTransFat, sodium: totalSodium, carbs: totalCarbs, dietaryFiber: totalDietaryFiber, sugars: totalSugars, protein: totalProtein, image: image)
            
            inventory.append(newItem)
            
        }
    
        
        return inventory
    }
}



