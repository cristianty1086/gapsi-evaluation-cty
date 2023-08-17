//
//  InitialData.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 16/08/23.
//

import Foundation

class InitialData : Codable {
    
    var searchResult:SearchResult
    
    init() {
        searchResult = SearchResult()
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        searchResult = try container.decodeIfPresent(SearchResult.self, forKey: .searchResult) ?? SearchResult()
    }
    
}
