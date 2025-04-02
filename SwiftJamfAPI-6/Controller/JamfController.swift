//
//  JamfController.swift
//  JamfList
//
//  Created by Armin Briegel on 2022-12-20.
//

import Foundation


class JamfController: ObservableObject {
    
  @Published var computers: [Computer] = []
  @Published var scripts: [Script] = []
  
  @Published var isLoading = false
  @Published var needsCredentials = false
  @Published var connected = false
  @Published var hasError = false
  @Published var debugStatus = false
  
  var server: String { UserDefaults.standard.string(forKey: "server") ?? "" }
  var username: String { UserDefaults.standard.string(forKey: "username") ?? "" }
  var password = ""
  
  var auth: JamfAuthToken?
  
  @MainActor
  func load() async {
    isLoading = true
      
    defer { isLoading = false }
    
    if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
      // preview mode return sample data
      computers = Computer.samples
      return
    }
    
      // not in preview mode
       
      
      //              ##############################################################
      //              Connections
      //              ##############################################################
      
      
       // attempt to get an auth token
       await connect()
      
      // only continue if connected
          guard connected, let auth = auth else { return }

      //              ##############################################################
      //              Computers
      //              ##############################################################
      
    if let fetchedComputers = try? await Computer.getAll(server: server, argStatus: false, auth: auth, itemID: []) {
            computers = fetchedComputers
//              print(computers)
          } else {
            hasError = true
          }
      
      //              ##############################################################
      //              Scripts
      //              ##############################################################
      
//          if let fetchedScripts = try? await Script.getAll(server: server, auth: auth) {
//            scripts = fetchedScripts
////              print(computers)
//          } else {
//            hasError = true
//          }
//
//
//
//    // simulate loading time
//    try? await Task.sleep(nanoseconds: 3_000_000_000)
//    // for now, also return sample data
//    computers = Computer.samples
//    // and set an error, just for the UI
//    hasError = true
  }
    
    @MainActor
      func connect() async {
          print("Running connect")
        // do we have all credentials?
        if server.isEmpty || username.isEmpty {
          needsCredentials = true
          connected = false
          return
        }
        
        if password.isEmpty {
          // try to get password from keychain
          guard let pwFromKeychain = try? Keychain.getPassword(service: server, account: username)
          else {
            needsCredentials = true
            connected = false
            return
          }
          password = pwFromKeychain
        }
        
        if auth == nil {
            print("no token yet, get one")
          auth = try? await JamfAuthToken.get(server: server, username: username, password: password)
          if auth == nil {
              print("couldn't get a token, most likely the credentials are wrong")
            hasError = true
            needsCredentials = true
            connected = false
            return
          }
        }
        
        print("we have a token, all is good")
        needsCredentials = false
        hasError = false
        connected = true
      }
    
    func debugMode(message: String) {
        
        if debugStatus == true {
            
            print("########################")
            print("DEBUG")
            print("########################")
            print(message)
        }
    }
    
    
    func getRequestURL(
      endpoint: String,
      appending paths: [String] = [],
      queryItems: [String:String] = [:],
      server: String
    ) throws -> URL {
        
        print("Running: getRequestURL")
        print("Server is:\(server)")
        print("Endpoint is:\(endpoint)")

      // assemble the URL for the Jamf API
      guard var components = URLComponents(string: server)
      else {
        throw JamfAPIError.badURL
      }
      var path: NSString = endpoint as NSString
      paths.forEach {
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
        
  print("Returning url:\(url)")
        
      return url
    }
}
