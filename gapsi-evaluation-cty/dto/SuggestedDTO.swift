//
//  SuggestedDTO.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 5/08/23.
//

import Foundation

class SuggestedDTO : Codable{
    
    var suggested_list : [String]
    
    init() {
        suggested_list = []
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        suggested_list = []
        if let data = try container.decodeIfPresent([String].self, forKey: .suggested_list) {
            self.suggested_list = data
        }
    }
    
}
