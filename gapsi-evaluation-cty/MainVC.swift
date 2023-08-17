//
//  MainVC.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 5/08/23.
//

import Foundation
import UIKit

class MainVC : UIViewController, UITableViewDataSource, UITableViewDelegate, RequestProtocol {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableSuggested: UITableView!
    @IBOutlet weak var tableProduct: UITableView!
    
    var suggested : [String] = []
    var products : [Product] = []
    
    override func viewDidLoad() {
        tableSuggested.dataSource = self
        tableProduct.dataSource = self
        
        tableSuggested.delegate = self
        tableProduct.delegate = self
        
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
        let suggestedDTO = SuggestedDTO()
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
            cell.txtTitle?.text = item.name
            cell.txtPrice?.text = "$ " + String(item.price)
            if (item.image != "") {
                Utilities.downloadImage(from: URL(string: item.image)!, imageView: cell.imgProduct)
            }
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == tableSuggested) {
            let sugerencia = self.suggested[indexPath.row]
            txtSearch.text = sugerencia
            
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
    }
    
    // Request Protocol
    func sucess(data: Any) {
        
        if let productoDTO = data as? ProductDTO {
            if (productoDTO.responseStatus != "PRODUCT_FOUND_RESPONSE") {
                error(msg: productoDTO.responseMessage)
                return
            }
            
            let stacks = productoDTO.item.props.pageProps.initialData.searchResult.itemStacks
            
            if (stacks.count > 0) {
                products = stacks[0].items.filter{
                    (producto) -> Bool in
                    producto.price != 0
                }
            }
            DispatchQueue.main.async {
                self.tableProduct.reloadData()
            }
        }
        
    }
    
    // Request Protocol
    func error(msg: String) {
        print(msg)
    }
}
