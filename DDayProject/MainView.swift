//
//  ContentView.swift
//  DDayProject
//
//  Created by Tyger Hwang on 5/25/24.
//

import SwiftUI

class MainViewModel : ObservableObject {
    @Published var dDays : [DDay] = []
    
    func addItem (_ item: DDay) -> Void {
        dDays.append(item)
        print(dDays)
    }
}

struct MainView: View {
    
    @StateObject var viewModel : MainViewModel = MainViewModel()
    @State var isCreate : Bool = false
    
    var body: some View {
        NavigationView {
            List(self.viewModel.dDays) { item in
                Text(item.date.description)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("DDay")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Left Button") {
                        // Left button action
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isCreate.toggle()
                    }label: {
                        Text("Create")
                    }.sheet(isPresented: self.$isCreate) {
                        EditView { item in
                            self.viewModel.addItem(item)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .previewDisplayName("Light")
                .colorScheme(.light)
            MainView()
                .previewDisplayName("Dark")
                .colorScheme(.dark)
        }
    }
}
