
import SwiftUI

class EditViewModel : ObservableObject {
    @Published var date : Date = Date()
    @Published var title : String = ""
    @Published var isShowPicker : Bool = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        return formatter
    }()
    
    func formattedDate() -> String {
        return dateFormatter.string(from: date)
    }
}

struct EditView: View {
    
    @ObservedObject var viewModel : EditViewModel = EditViewModel()
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) private var presentationMode
    
    var onSuccess: ((DDay) -> Void)?
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
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
                    if let onSuccess = self.onSuccess {
                        onSuccess(DDay(title: self.viewModel.title, date: self.viewModel.date))
                    }
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Text("Save")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                }.padding()
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
                                self.viewModel.isShowPicker.toggle()
                            }
                        }label: {
                            Text(self.viewModel.formattedDate())
                                .foregroundColor(self.viewModel.isShowPicker ? .blue : .primary)
                                .fontWeight(.regular)
                                .font(.system(size: 18)).padding(EdgeInsets(
                                    top: 6, leading: 12, bottom: 6, trailing: 12))
                        }.background(
                            colorScheme == .light ? Color(red: 225/255, green: 225/255, blue: 225/255) :
                                Color(red: 55/255, green: 55/255, blue: 55/255))
                        .cornerRadius(8)
                    }
                    if self.viewModel.isShowPicker {
                        DatePicker(
                            "DatePicker",
                            selection: self.$viewModel.date,
                            displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .frame(height: 320)
                    }
                    TextField("Enter Title", text: self.$viewModel.title)
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



