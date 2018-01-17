//
//  ViewController.swift
//  LCBO_Project
//
//  Created by Naga Sai Jyothi  on 2017-12-12.
//  Copyright © 2017 Naga Sai Jyothi . All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Properties
    let container = Container()
    let store: [String] = ["Stores","Products"]
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - UITableDelegate,UITableDataSource
extension MainViewController:UITableViewDelegate,UITableViewDataSource{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.store.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 30
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath) as! MainPageTableView
        let store = self.store[indexPath.section]
        cell.cellTittle.text = store
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0){
            let storesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoresSearchVC") as! StoreSearchViewController
            self.navigationController?.pushViewController(storesVC, animated: true)
        }
        if(indexPath.section == 1){
            let productsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductsVC") as! ProductsInfoViewController
            self.navigationController?.pushViewController(productsVC, animated: true)
        }
    }
}
