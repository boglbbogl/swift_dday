//
//  ContentView.swift
//  DDayProject
//
//  Created by Tyger Hwang on 5/25/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var isCreate : Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    isCreate.toggle()
                }label: {
                    Text("Create")
                }.sheet(isPresented: self.$isCreate) {
                    EditView()
                }
            }.navigationTitle("DDay")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDisplayName("Light")
                .colorScheme(.light)
            ContentView()
                .previewDisplayName("Dark")
                .colorScheme(.dark)
        }
    }
}
