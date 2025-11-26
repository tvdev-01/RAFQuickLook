//
//  ContentView.swift
//  RAFQuickLook
//
//  Created by Michael Costello on 25/11/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("rafIcon")
            VStack {
                Text("Fuji RAF - Quick Look").bold().padding(.bottom, 4)
                Text("Registered Preview / Thumbnail Extensions")
            }
            .padding(8)
        
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
