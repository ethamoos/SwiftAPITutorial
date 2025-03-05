//
//  MacApplications.swift
//  SwiftJamfAPI
//
//  Created by Amos Deane on 05/03/2025.
//



import Foundation


  // MARK: - MacApplication
  struct MacApplication: JamfObject, Codable {
    
    
    var id: String
    var name: String = ""
    
    static var getAllEndpoint = "/JSSResource/macapplications"


  }
  





//struct Script: JamfObject {
//  enum Priority: String, Codable {
//    case before = "BEFORE"
//    case after = "AFTER"
//  }
//  
//  var id: String
//  var name: String = ""
//  var info: String = ""
//  var notes: String = ""
//  var priority: Priority = .after
//  var parameter4: String = ""
//  var parameter5: String = ""
//  var parameter6: String = ""
//  var parameter7: String = ""
//  var parameter8: String = ""
//  var parameter9: String = ""
//  var parameter10: String = ""
//  var parameter11: String = ""
//  var osRequirements: String = ""
//  var scriptContents: String = ""
//  var categoryId: String = "-1"
//  var categoryName: String = ""
//
//static var getAllEndpoint = "/api/v1/scripts"
