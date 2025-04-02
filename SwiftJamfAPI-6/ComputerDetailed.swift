//
//  ComputerDetailed.swift
//  JamfList
//
//  Created by Amos Deane on 28/03/2025.
//




import Foundation

// MARK: - ComputerDetailedResponse
//struct ComputerDetailedResponse: Codable {
//  let totalCount: Int
//  let results: [ComputerDetailed]
//}

// MARK: - Result
struct ComputerDetailed: JamfObject {
  
  var id: String
  var udid: UUID
  
  struct General: Codable {
    var name: String
    var id: String
    let lastIPAddress, lastReportedIP, lastEnrolledDate: String?
  }
  
  static var getAllEndpoint = "/JSSResource/computers/id/"
  
  static func getAllURLComponents(server: String) throws -> URLComponents {
    guard let components = URLComponents(string: server)
    else {
      print("Error with url")
      throw JamfAPIError.badURL
    }
    print("components are:\(components)")
    return components
  }
}
