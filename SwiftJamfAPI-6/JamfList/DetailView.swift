//
//  DetailView.swift
//  JamfList
//
//  Created by Armin Briegel on 2022-12-15.
//

import SwiftUI

struct DetailView: View {
  var computer: Computer
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(computer.general.name)
        .font(.title)
      Divider()
      Text(computer.general.lastEnrolledDate.description)
      Text(computer.hardware.serialNumber)
      Text(computer.hardware.appleSilicon
           ? "Apple silicon" : "Intel")
      Text("macOS \(computer.operatingSystem.version)")
      Spacer()
    }
    .padding()
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(computer: Computer.sampleMacBookAir)
  }
}


//
//  ComputerDetailAltView.swift
//  JamfList
//
//  Created by Amos Deane on 28/03/2025.
//


import SwiftUI

struct ComputerDetailAltView: View {
    
    @EnvironmentObject var jamfController: JamfController

  var computer: Computer

  var body: some View {
    VStack(alignment: .leading) {
      Text(computer.general.name)
          .font(.title)
      Divider()
//      Text(computer.general.lastEnrolledDate.description)
      Text(computer.hardware.serialNumber ?? "")
      Text(computer.hardware.appleSilicon
           ? "Apple silicon" : "Intel")
      Text("macOS \(computer.operatingSystem.version ?? "")")
      Spacer()
    }
    .padding()
    .onAppear() {
        print("Navigated to: ComputerDetailAltView")
     
        Task {
            
            // Parameters:
            // endpoint: absolute path to the endpoint
            // appending: array of path components which will be appended to to `path`
            // queryItems: dictionary of String items that will be used to assemble query items
            
            let endpointRequest = "/JSSResource/computers/id/"
            let server = UserDefaults.standard.object(forKey: "server") as? String ?? String ()
            let serverRequest = try jamfController.getRequestURL(endpoint: endpointRequest, appending: [computer.id], server: server)
            print("serverRequest is now:\(serverRequest)")
            if let fetchedDetailedComputer = try? await ComputerDetailed.getAll(server: server, auth: jamfController.auth!) {
                let detailedComputer = fetchedDetailedComputer
                print(detailedComputer)
                
            } else {
                jamfController.hasError = true
                print("Error is:\(jamfController.hasError)")

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




