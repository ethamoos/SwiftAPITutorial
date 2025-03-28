//
//  ComputerDetailed.swift
//  JamfList
//
//  Created by Amos Deane on 28/03/2025.
//




import Foundation

// MARK: - ComputerDetailedResponse
//struct ComputerDetailedResponse: Codable {
//    let computer: ComputerDetailed
//}

// MARK: - ComputerDetailed
//struct ComputerDetailed: JamfObject, Hashable  {
//
//  var id: String
//
//
//
//
//  // This file was generated from JSON Schema using quicktype, do not modify it directly.
//  // To parse the JSON, add this file to your project and do:
//  //
//  //   let computerResponse = try? JSONDecoder().decode(ComputerResponse.self, from: jsonData)
//
//
//  // MARK: - ComputerResponse
struct ComputerDetailedResponse: Codable {
  let totalCount: Int
  let results: [ComputerDetailed]
}

// MARK: - Result
struct ComputerDetailed: JamfObject {
  
  var id: String
  
  struct General: Codable {
    var name: String
    let lastIPAddress, lastReportedIP: String?
    
  }
  
  
  
  // MARK: JamfObject implementation
  
  static var getAllEndpoint = "/JSSResource/computers/id/"
  
  // override getAllURLComponents to add query items
  static func getAllURLComponents(server: String) throws -> URLComponents {
    guard var components = URLComponents(string: server)
    else {
      throw JamfAPIError.badURL
    }
    components.path = self.getAllEndpoint
    
    return components
  }
}
