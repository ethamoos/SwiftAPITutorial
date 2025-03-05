//
//  JamfList.swift
//  jamf_list
//
//  Created by Armin Briegel on 2022-09-05.
//

import Foundation

@main

struct JamfList {
  
  enum JamfType: String {
    case computer
    case building
    case category
    case script
    case macApplication
  }
  
  static func main() async {
    let args = CommandLine.arguments
    
//    
//    print("args[1] is:\(args[1])")
//    print("args[2] is:\(args[2])")
//    print("args[3] is:\(args[3])")

    
    guard args.count > 3
    else {
      print("Not enough arguments")
      print("usage: jamf_list type server username [password]")
      exit(1)
    }
    
    // it is now safe to access `args[1...3]`
    guard let type = JamfType(rawValue: args[1])
    else {
      print("\(args[1]) is not a known type")
      exit(2)
    }
    
    // connection info
    let server = args[2]
    let username = args[3]
    var password = ""
    
    print("Args count is:\(args.count)")
    // if there is a fourth argument, assign it to password
    if args.count > 4 {
      password = args[4]
    } else {
      // no password argument, get from keychain
      guard let passwordFromKeychain = try? Keychain.getPassword(service: server, account: username)
      else {
        print("Could not get password from keychain")
        exit(2)
      }
      password = passwordFromKeychain
    }
    
    // errors thrown in the do block will be processed in the catch block
    do {
      // get authentication token
      let auth = try await JamfAuthToken.get(server: server, username: username, password: password)
      
//      print("Auth is:\(auth)")
      switch type {
      case .macApplication:
        
        print("Fetching Applications")
        let macApplications = try await MacApplication.getAll(server: server, auth: auth)
        
        for macApplication in macApplications {
          print(macApplication.id,
                macApplication.name)
        }
        
      case .building:
        let buildings = try await Building.getAll(server: server, auth: auth)
        
        for building in buildings {
          print(building.id,
                building.name)
        }
        
      case .category:
        let categories = try await Category.getAll(server: server, auth: auth)
        
        for category in categories {
          print(category.id,
                category.name,
                category.priority)
        }
        
      case .computer:
        // get computers
        let computers = try await Computer.getAll(server: server, auth: auth)
        
        for computer in computers {
          print(computer.id,
                computer.general.name)
        }
        
      case .script:
        //get scripts
        let scripts = try await Script.getAll(server:server, auth: auth)
        
        for script in scripts {
          print(script.id,
                script.name,
                "(\(script.scriptContents.split(separator: "\n").count) lines of code)")
        }
      }
      // catch the errors
    } catch JamfAPIError.badURL {
      print("could not create API URL")
      exit(11)
    } catch JamfAPIError.requestFailed {
      print("API request failed")
      exit(12)
    } catch JamfAPIError.http(let statusCode) {
      print("HTTP error: \(statusCode)")
      exit(13)
    } catch JamfAPIError.decode {
      print("could not decode JSON")
      exit(14)
    } catch {
      print("other error: \(error)")
      exit(99)
    }
  }
}
