import Foundation

// MARK: - ComputerDetailedResponse
//struct ComputerDetailedResponse: Codable {
//  let totalCount: Int
//  let results: [ComputerDetailed]
//}

// MARK: - Result
struct ComputerDetailed: JamfObject {
  
  var id: String
  struct General: Codable {
    var name: String
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
