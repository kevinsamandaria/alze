//
//  Home.swift
//  Alze
//
//  Created by Ridho Saputra on 14/06/22.
//

import SwiftUI

struct Main: View {

    
    var body: some View {
        TabView {
//            Home(userData: nil)
//                .tabItem {
//                    Label("Goals", systemImage: "house.fill")
//                }
            Text("History")
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .accentColor(.indigo)
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
