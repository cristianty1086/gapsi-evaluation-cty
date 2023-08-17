//
//  ProductoDTO.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 5/08/23.
//

import Foundation

public class ProductDTO : Codable
{
    var responseStatus : String
    var responseMessage : String
    var sortStrategy : String
    var domainCode : String
    var keyword : String
    var item : Item
    
    init () {
        responseStatus = ""
        responseMessage = ""
        sortStrategy = ""
        domainCode = ""
        keyword = ""
        item = Item()
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseStatus = try container.decode(String.self, forKey: .responseStatus)
        responseMessage = try container.decode(String.self, forKey: .responseMessage)
        sortStrategy = try container.decode(String.self, forKey: .sortStrategy)
        domainCode = try container.decode(String.self, forKey: .domainCode)
        keyword = try container.decode(String.self, forKey: .keyword)
        item = try container.decodeIfPresent(Item.self, forKey: .item) ?? Item()
    }
     
}



