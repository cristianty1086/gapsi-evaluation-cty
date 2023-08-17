//
//  Props.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 16/08/23.
//

import Foundation

class Props : Codable {
    
    var pageProps:PageProps
    
    init() {
        pageProps = PageProps()
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pageProps = try container.decodeIfPresent(PageProps.self, forKey: .pageProps) ?? PageProps()
    }
    
}
