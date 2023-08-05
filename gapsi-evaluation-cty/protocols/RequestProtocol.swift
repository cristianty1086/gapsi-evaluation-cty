//
//  RequestProtocol.swift
//  gapsi-evaluation-cty
//
//  Created by Cristian Tinoco Yurivilca on 5/08/23.
//

import Foundation

protocol RequestProtocol {
    func sucess(data : Any) -> Void
    func error(msg: String) -> Void
}
