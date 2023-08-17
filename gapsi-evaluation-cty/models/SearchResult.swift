//
//  SearchResult.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 16/08/23.
//

import Foundation

class SearchResult : Codable {
    
    var title:String
    var aggregatedCount:Int64
    var itemStacks:[Stack]
    var count:Int64
    var gridItemsCount:Int64
    
    init() {
        title = ""
        aggregatedCount = 0
        itemStacks = []
        count = 0
        gridItemsCount = 0
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        aggregatedCount = try container.decodeIfPresent(Int64.self, forKey: .aggregatedCount) ?? 0
        itemStacks = try container.decodeIfPresent([Stack].self, forKey: .itemStacks) ?? []
        count = try container.decodeIfPresent(Int64.self, forKey: .count) ?? 0
        gridItemsCount = try container.decodeIfPresent(Int64.self, forKey: .gridItemsCount) ?? 0
    }
    
}
