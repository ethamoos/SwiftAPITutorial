//
//  Building.swift
//  SwiftJamfAPI
//
//  Created by Amos Deane on 05/03/2025.
//

// MARK: - Building

import Foundation

struct Building: JamfObject {
  
  var id: String
    let name: String
  
  static var getAllEndpoint = "/api/v1/buildings"

}
