//
//  StoreSearchViewController.swift
//  LCBO_Project
//
//  Created by Naga Sai Jyothi  on 2017-12-15.
//  Copyright © 2017 Naga Sai Jyothi . All rights reserved.
//

import UIKit

class StoreSearchViewController: UIViewController {
   
    //MARK: - Properties
    let container = Container()
    
    //MARK: - IBOutlets
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var postalCodeTF: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBtn.layer.cornerRadius = 20
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - IBActions
    @IBAction func searchBtnPressed(_ sender: Any) {
        
        self.container.searchByPostalCode = self.postalCodeTF.text!
        container.storesContainer {(error)in DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
    
}

extension StoreSearchViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return container.storesList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! StoresTableViewCell
        let store = container.storesList[indexPath.section]
        let locationName = store["locationName"]
        let locationAddress1 = store["locationAddress1"]
        let locationAddress2 = store["locationAddress2"]
        let postalCode = store["postalCode"]
        let city = store["locationCityName"]
        
        cell.storeInfo.text = "StoreName: \(locationName!) \nAddress: \(locationAddress1!) \(locationAddress2!) \nCity: \(city!) \nPostalCode: \(postalCode!) \n for more info clik here.."
        
        return cell
    }
}
