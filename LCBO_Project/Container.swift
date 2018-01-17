//
//  Container.swift
//  LCBO_Project
//
//  Created by Naga Sai Jyothi  on 2017-12-13.
//  Copyright © 2017 Naga Sai Jyothi . All rights reserved.
//

import UIKit

class Container: NSObject {
    //MARK: - Properties
    var storesList: [Dictionary<String, Any>] = []
    var searchByPostalCode: String = ""
    var selectedProduct : String = ""
    var productsInfo: [Dictionary<String, Any>] = []
 
    //MARK: - Store Container Methods
    func storesContainer(completion: @escaping (Error?) -> ()) {
        guard var LCBO_URL = URL(string: "https://api.lcbo.com/stores?postalCode=000")else {return}
        let validPostalCode = self.validZipCode(postalCode: self.searchByPostalCode)
        if(validPostalCode == true){
                let URlWithPostalCode = "https://api.lcbo.com/stores?postalCode=" + self.searchByPostalCode
                LCBO_URL  = URL(string: URlWithPostalCode)!
                print("Valid Postal Code")
               }else{
                print("Invalid Postal Code")
               }
        let task = URLSession.shared.dataTask(with: LCBO_URL) { (data, response, err) in
        do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String:Any]]
                self.storesList = json
                print(self.storesList[1])
                let store = self.storesList[1]
                print(store["locationName"]!)
                completion(nil)
            }
            catch{
                print("Please enter valid postalCode")
            }
        }
        task.resume()
   }

    func validZipCode(postalCode:String)->Bool{
        let postalcodeRegex = "^[a-zA-Z][0-9][a-zA-Z][0-9][a-zA-Z][0-9]$"
        let pinPredicate = NSPredicate(format: "SELF MATCHES %@", postalcodeRegex)
        let bool = pinPredicate.evaluate(with: postalCode) as Bool
        return bool
    }
    
    //MARK: - Product Container methods
    func productsContainer(selectedItem:String, completion: @escaping (Error?) -> ()) {
        self.selectedProduct = selectedItem
       // print(self.selectedProduct)
        guard let jsonURL = URL(string: "https://api.lcbo.com/products/?itemKeyword="+self.selectedProduct) else {
            print("Server Error")
            self.productsInfo.removeAll()
            return
            
        }
        let task =  URLSession.shared.dataTask(with: jsonURL) { (data, rasponse, err) in
        guard let content = data else {print("Data not found")
        return
        }
        do{
            let productsJsonData = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as! [String:Any]
            let products = productsJsonData["products"]
            self.productsInfo = products! as! [Dictionary<String, Any>]
            completion(nil)
            }
        catch{
            print("Error: \(err.debugDescription)")
            }
        }
        task.resume()
    }
}

