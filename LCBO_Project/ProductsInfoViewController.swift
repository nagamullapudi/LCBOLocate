//
//  ProductsInfoViewController.swift
//  LCBO_Project
//
//  Created by Naga Sai Jyothi  on 2017-12-15.
//  Copyright © 2017 Naga Sai Jyothi . All rights reserved.
//

import UIKit

class ProductsInfoViewController: UIViewController {
   
    //MARK: - IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productsPV: UIPickerView!
    
    //MARK: - PROPERTIES
    let productsCell = ProductsTableViewCell()
    let container = Container()
    var count = 0
    let productList =  ["Heineken","Canadian%20Club%20Whisky","Smirnoff%20Vodka","Bacardi%20Superior%20Rum","Sogrape%20Mateus%20Rosé","Smirnoff%20Vodka","Walker's%20Special%20Old%20Whisky","Seagrams%20V.O.%20Whisky","Pama%20Pomegranate%20Liquor"]
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.container.selectedProduct = "Heineken"
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

//MARK: - UIPICKERVIEW DELEGATE AND DATASOURCE
extension ProductsInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return productList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let convertedData = self.productList[row].replacingOccurrences(of: "%20", with: " ")
        return convertedData
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.container.selectedProduct = self.productList[row]
        self.container.productsContainer(selectedItem: self.container.selectedProduct, completion:{ (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        count = count + 1
        print(count)
    }
}

//MARK: - UITABLEVIEW DATASOURCE AND DELEGATE
extension ProductsInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.container.productsInfo.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ProductsTableViewCell

        let product = self.container.productsInfo[indexPath.section]
        let fullProductInfo = "ItemName:\(product["itemName"]!)\nItemNumber:\(product["itemNumber"]!)\nLiquorType:\(product["liquorType"]!)\nAlcoholPercentage:\(product["alcoholPercentage"]!)\nProducingCountry:\(product["producingCountry"]!)\nProductQuantity:\(product["productQuantity"]!)\nPrice:\(product["price"]!)\nOnlineProductQuantity:\(product["onlineProductQuantity"]!)\nTastingNotes:\(product["tastingNotes"]!)"
        productCell.productInfo.text = fullProductInfo
        
        return productCell
    }
}

