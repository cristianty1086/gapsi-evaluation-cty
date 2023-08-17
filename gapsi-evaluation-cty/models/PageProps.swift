//
//  PageProps.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 16/08/23.
//

import Foundation

class PageProps : Codable {
    
    var initialData:InitialData
    var isomorphicSessionId:String
    var adSessionId:String
    var nonce:String
    
    init() {
        isomorphicSessionId = ""
        adSessionId = ""
        nonce = ""
        initialData = InitialData()
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isomorphicSessionId = try container.decodeIfPresent(String.self, forKey: .isomorphicSessionId) ?? ""
        adSessionId = try container.decodeIfPresent(String.self, forKey: .adSessionId) ?? ""
        nonce = try container.decodeIfPresent(String.self, forKey: .nonce) ?? ""
        initialData = try container.decodeIfPresent(InitialData.self, forKey: .initialData) ?? InitialData()
    }
    
}
