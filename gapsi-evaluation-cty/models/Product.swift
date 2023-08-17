//
//  Product.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 5/08/23.
//

import Foundation

class Product : Codable {
    
    var id:String
    var name:String
    var price:Int64
    var image:String
    var priceInfo:PriceInfo
    
    init() {
        id = ""
        name = ""
        price = 0
        image = ""
        priceInfo = PriceInfo()
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        price = try container.decodeIfPresent(Int64.self, forKey: .price) ?? 0
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        priceInfo = try container.decodeIfPresent(PriceInfo.self, forKey: .priceInfo) ?? PriceInfo()
    }
    
}
