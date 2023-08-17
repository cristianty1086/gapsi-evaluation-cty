//
//  Stack.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 16/08/23.
//

import Foundation

class Stack : Codable {
    
    var title:String
    var totalItemCountDisplay:String
    var count:Int
    var items:[Product]
    
    init() {
        title = ""
        totalItemCountDisplay = ""
        count = 0
        items = []
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        totalItemCountDisplay = try container.decodeIfPresent(String.self, forKey: .totalItemCountDisplay) ?? ""
        count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
        items = try container.decodeIfPresent([Product].self, forKey: .items) ?? []
    }
    
}
