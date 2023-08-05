//
//  MainVC.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 5/08/23.
//

import Foundation
import UIKit

class MainVC : UIViewController, UITableViewDataSource, RequestProtocol {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableSuggested: UITableView!
    @IBOutlet weak var tableProduct: UITableView!
    
    var suggested : [String] = []
    var products : [Product] = []
    
    override func viewDidLoad() {
        tableSuggested.dataSource = self
        tableProduct.dataSource = self
        populate()
        
        // register cell
        tableProduct.register(UITableViewCell.self, forCellReuseIdentifier: "cellProduct")
        tableSuggested.register(UITableViewCell.self, forCellReuseIdentifier: "cellSuggested")
    }
    
    func populate() {
        
        let _suggested = Utilities.getSuggested()
        if (_suggested != nil) {
            suggested = _suggested!.suggested_list
        }
        
        let prod = Product()
        prod.title = "Juguete tayloy 12 para niños, marca 2022"
        prod.price = "$ 45.0"
        prod.image = "https://res.cloudinary.com/demo/image/upload/v1312461204/sample.jpg"
        products.append(prod)
        products.append(prod)
        products.append(prod)
        // --
        
    }
    
    @IBAction func onBuscar(_ sender: Any) {
        
        if (txtSearch.text == nil || txtSearch.text == "") {
            print("Ingrese un nombre a buscar")
            return
        }
        
        var _suggested = Utilities.getSuggested()
        if (_suggested != nil) {
            suggested = _suggested!.suggested_list
        } else {
            suggested = []
        }
        
        suggested.insert(txtSearch.text!, at: 0)
        var suggestedDTO = SuggestedDTO()
        suggestedDTO.suggested_list = suggested
        Utilities.setSuggested(suggesteds: suggestedDTO)
        tableSuggested.reloadData()
        
        // get request
        let page = "1"
        let query = txtSearch.text
        let strUrl = "https://00672285.us-south.apigw.appdomain.cloud/demo-gapsi/search?&query="
                    + query! + "&page=" + page
        print(strUrl)
        let urlWS = URL(string: strUrl)
        let key = "adb8204d-d574-4394-8c1a-53226a40876e"
        Utilities.sendGetRequest(protocolo: self,
                                 url: urlWS!,
                                 type: ProductDTO.self,
                                 ibmKey: key)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == tableSuggested) {
            return suggested.count
        } else if (tableView == tableProduct) {
            return products.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == tableSuggested) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellSuggested",
                                                     for: indexPath) as! CellSuggested
            cell.name?.text = self.suggested[indexPath.row]
            return cell
        } else if (tableView == tableProduct) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellProduct",
                                                         for: indexPath) as! CellProduct
            let item = self.products[indexPath.row]
            cell.txtTitle?.text = item.title
            cell.txtPrice?.text = item.price
            Utilities.downloadImage(from: URL(string: item.image)!, imageView: cell.imgProduct)
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    // Request Protocol
    func sucess(data: Any) {
        
        if let productoDTO = data as? ProductDTO {
            if (productoDTO.status != "success") {
                error(msg: productoDTO.message)
                return
            }
            
            products = productoDTO.data
            tableProduct.reloadData()
        }
        
    }
    
    // Request Protocol
    func error(msg: String) {
        print(msg)
    }
}
