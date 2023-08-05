//
//  Product.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 5/08/23.
//

import Foundation

class Product : Codable {
    
    var title:String
    var price:String
    var image:String
    
    init() {
        title = ""
        price = ""
        image = ""
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        price = try container.decodeIfPresent(String.self, forKey: .price) ?? ""
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
    }
    
}
