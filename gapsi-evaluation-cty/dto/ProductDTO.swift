//
//  ProductoDTO.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 5/08/23.
//

import Foundation

public class ProductDTO : Codable
{
    var status : String
    var message : String
    var data : [Product]
    
    init () {
        status = ""
        message = ""
        data = []
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
        data = []
        if let data = try container.decodeIfPresent([Product].self, forKey: .data) {
            self.data = data
        }
    }
     
}



