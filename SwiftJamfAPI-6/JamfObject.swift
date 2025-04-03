//
//  JamfObject.swift
//  jamf_list
//
//  Created by Armin Briegel on 2022-10-26.
//

import Foundation

protocol JamfObject: Codable, Identifiable {
  var id: String { get set }
  
  static var getAllEndpoint: String { get }
  
  /** Build the URL for the request to fetch all objects */
  static func getAllURLComponents(server: String) throws -> URLComponents
  
  /** Gets a list of all objects from the Jamf Pro Server */
  static func getAll(server: String, argStatus: Bool, auth: JamfAuthToken, itemID: [String]) async throws -> [Self]
}

extension JamfObject {
  
  /** build the URL for the request to fetch all categories */
  static func getAllURLComponents(server: String) throws -> URLComponents {
    // assemble the URL for the Jamf API
    guard var components = URLComponents(string: server)
    else {
      throw JamfAPIError.badURL
    }
    components.path = getAllEndpoint
    
    return components
  }

//              ##############################################################
//              getAll
//              ##############################################################

  static func getAll(server: String, argStatus: Bool, auth: JamfAuthToken, itemID: [String]) async throws -> [Self] {
    // MARK: Prepare Request
    
    let url: URL
    if argStatus == true {
       url = try getURLWithArg(endpoint: getAllEndpoint, itemID: itemID, server: server)
    } else {
       url = try getURLNoArg(server: server)
    }
    
    // MARK: Send Request and get Data
    // create the request
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("Bearer " + auth.token, forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    // send request and get data
    guard let (data, response) = try? await URLSession.shared.data(for: request)
    else {
      throw JamfAPIError.requestFailed
    }
    
    // MARK: Handle Error
    // check the response code
    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
    if statusCode != 200 {
      // error getting token
      throw JamfAPIError.http(statusCode)
    }
    
//    ##############################################################
//    DEBUG
//    ##############################################################
//    print("Get the returned data to debug")
//    print(String(data: data, encoding: .utf8) ?? "no data")
    
    // MARK: Parse JSON Data
    let decoder = JSONDecoder()
    print("Trying to decode the data")
    // set date decoding to match Jamf's date format
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    
    do {
      
      if argStatus == true {
        let result = try decoder.decode(JamfResultsComputerDetailed<Self>.self, from: data)
        return result.computer
      } else {
        let result = try decoder.decode(JamfResults<Self>.self, from: data)
        return result.results
      }
      // handle decoding errors
      // see DecodingError documentation for details
    } catch let DecodingError.dataCorrupted(context) {
      print("\(context.codingPath): data corrupted: \(context.debugDescription)")
    } catch let DecodingError.keyNotFound(key, context) {
      print("\(context.codingPath): key \(key) not found: \(context.debugDescription)")
    } catch let DecodingError.valueNotFound(value, context) {
      print("\(context.codingPath): value \(value) not found: \(context.debugDescription)")
    } catch let DecodingError.typeMismatch(type, context) {
      print("\(context.codingPath): type \(type) mismatch: \(context.debugDescription)")
    } catch {
      print("error: ", error)
    }
    
    throw JamfAPIError.decode
  }
  
  static func getURLNoArg(server: String) throws -> URL {
    
    let components = try getAllURLComponents(server: server)
    
    guard let url = components.url
    else {
      throw JamfAPIError.badURL
    }
    return url
  }

  
  static func getURLWithArg(
    endpoint: String,
     itemID: [String] = [],
    queryItems: [String:String] = [:],
    server: String
   ) throws -> URL {
    // assemble the URL for the Jamf API
    guard var components = URLComponents(string: server)
    else {
     throw JamfAPIError.badURL
    }
    var path: NSString = endpoint as NSString
     itemID.forEach {
     path = path.appendingPathComponent($0) as NSString
    }
    components.path = path as String
    var urlQueryItems = [URLQueryItem]()
      
    for (key, value) in queryItems {
     urlQueryItems.append(URLQueryItem(name: key, value: value))
    }
    components.queryItems = urlQueryItems
    guard let url = components.url else {
     throw JamfAPIError.badURL
    }
  print("Url is:\(url)")
    return url
   }
}

struct JamfResults<T: JamfObject>: Codable {
  var totalCount: Int
  var results: [T]
}

struct JamfResultsComputerDetailed<T: JamfObject>: Codable {
//  var totalCount: Int
  var computer: [T]
}
