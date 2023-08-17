//
//  Item.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 16/08/23.
//

import Foundation

class Item : Codable {
    
    var assetPrefix:String
    var appGip:Bool
    var buildId:String
    var locale:String
    var gip:Bool
    var defaultLocale:String
    var page:String
    var isFallback:Bool
    var customServer:Bool
    var props:Props
    
    init() {
        assetPrefix = ""
        appGip = false
        buildId = ""
        locale = ""
        gip = false
        defaultLocale = ""
        page = ""
        isFallback = false
        customServer = false
        props = Props()
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        assetPrefix = try container.decodeIfPresent(String.self, forKey: .assetPrefix) ?? ""
        appGip = try container.decodeIfPresent(Bool.self, forKey: .appGip) ?? false
        buildId = try container.decodeIfPresent(String.self, forKey: .buildId) ?? ""
        locale = try container.decodeIfPresent(String.self, forKey: .locale) ?? ""
        gip = try container.decodeIfPresent(Bool.self, forKey: .gip) ?? false
        defaultLocale = try container.decodeIfPresent(String.self, forKey: .defaultLocale) ?? ""
        page = try container.decodeIfPresent(String.self, forKey: .page) ?? ""
        isFallback = try container.decodeIfPresent(Bool.self, forKey: .isFallback) ?? false
        customServer = try container.decodeIfPresent(Bool.self, forKey: .customServer) ?? false
        props = try container.decodeIfPresent(Props.self, forKey: .props) ?? Props()
    }
    
}
