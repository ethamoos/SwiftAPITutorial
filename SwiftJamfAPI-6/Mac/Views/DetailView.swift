//
//  DetailView.swift
//  JamfList
//
//  Created by Armin Briegel on 2022-12-15.
//

import SwiftUI

struct DetailView: View {
    
//  @EnvironmentObject var controller: JamfController
  @StateObject var controller = JamfController()

  var computer: Computer

  var body: some View {
    VStack(alignment: .leading) {
      Text(computer.general.name)
          .font(.title)
      Divider()
//      Text(computer.general.lastEnrolledDate.description)
      Text(computer.hardware.serialNumber)
      Text(computer.hardware.appleSilicon
           ? "Apple silicon" : "Intel")
      Text("macOS \(computer.operatingSystem.version)")
      Spacer()
    }
    .padding()
    .onAppear() {
        print("Navigated to: ComputerDetailView")
     
      Task {
        
        
        print("make sure have token")
        await controller.load()

        // Parameters:
        // endpoint: absolute path to the endpoint
        // appending: array of path components which will be appended to to `path`
        // queryItems: dictionary of String items that will be used to assemble query items
        
        let endpointRequest = "/JSSResource/computers/id/"
        let server = UserDefaults.standard.object(forKey: "server") as? String ?? String ()
        let serverRequest = try controller.getRequestURL(endpoint: endpointRequest, appending: [computer.id], server: server)
        print("ServerRequest is:\(serverRequest)")
        
        if (controller.auth != nil) {
          
          print("Running: getAll for ComputerDetailed")
          
          if let fetchedDetailedComputer = try? await ComputerDetailed.getAll(server: server, argStatus: true, auth: controller.auth!, itemID: [computer.id] ) {
            let detailedComputer = fetchedDetailedComputer
            print("detailedComputer is:\(detailedComputer)")
            print("Computer ID is:\(computer.id)")
          } else {
            controller.hasError = true
            print("Error from getAll request")
          }
        } else {
          print("No value for token")
        }
      }
    }
  }
}

//struct DetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    DetailView(computer: Computer.sampleMacBookPro)
//  }
//}




