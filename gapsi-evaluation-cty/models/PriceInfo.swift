//
//  PriceInfo.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 16/08/23.
//

import Foundation

class PriceInfo : Codable {
    
    var itemPrice:String
    
    init() {
        itemPrice = ""
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        itemPrice = try container.decodeIfPresent(String.self, forKey: .itemPrice) ?? ""
    }
    
}
