//
//  EditView.swift
//  DDayProject
//
//  Created by Tyger Hwang on 5/25/24.
//

import SwiftUI

struct EditView: View {
    
    private var isSuccess : Bool = false
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) private var presentationMode
    @State private var currentDate = Date()
    @State private var isShowPicker : Bool = false
    @State private var title : String = ""
    @State private var subTitle : String = ""
    
    private var dateFormatter: DateFormatter {
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy. MM. dd" // 사용할 포맷 설정
          return formatter
      }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Text("Close")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                }.padding()
                Spacer()
                Text("New")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                Spacer()
                Button {
                    
                }label: {
                    Text("Save")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                }.padding()
                    .disabled(!self.isSuccess)
            }
            Form {
                Section {
                    HStack {
                        Text("Date")
                            .fontWeight(.regular)
                            .font(.system(size: 18))
                        Spacer()
                        Button {
                            withAnimation {
                                self.isShowPicker.toggle()
                            }
                        }label: {
                            Text("\(dateFormatter.string(from: self.currentDate))")
                                .foregroundColor(self.isShowPicker ? .blue : .primary)
                                .fontWeight(.regular)
                                .font(.system(size: 18)).padding(EdgeInsets(
                                top: 6, leading: 12, bottom: 6, trailing: 12))
                        }.background(
                            colorScheme == .light ? Color(red: 225/255, green: 225/255, blue: 225/255) :
                            Color(red: 55/255, green: 55/255, blue: 55/255))
                            .cornerRadius(8)
                    }
                    if self.isShowPicker {
                        DatePicker(
                            "DatePicker",
                            selection: self.$currentDate,
                            displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .frame(height: 320)
                    }
                    TextField("Enter Title", text: self.$title)
                        .font(.system(size: 18))
                }
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EditView()
                .previewDisplayName("Light")
                .preferredColorScheme(.light)
            EditView()
                .previewDisplayName("Dark")
                .preferredColorScheme(.dark)
        }
    }
}

