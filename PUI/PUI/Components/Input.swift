import Foundation
import SwiftUI

public extension PUI {
    struct TextField: View {
        enum TextFieldType {
            case password
            case singleLine
            case multiLine
        }

        var title: String?
//        @State var description: String?
        
        var placeholder: String
        
        var type: TextFieldType
        
        @Binding var text: String

        public var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                // Лейбл над текстовым полем
                if let title {
                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                // Текстовое поле в зависимости от типа
                Group {
                    switch type {
                    case .password:
//                        SecureField(placeholder, text: $text)
                        SecureField("placeholder", text: $text)
                    case .singleLine:
                        SwiftUI.TextField(placeholder, text: $text)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    case .multiLine:
                        TextEditor(text: $text)
                            .frame(minHeight: 100)
                    }
                }
                
                
                
                
                .padding()
                .background(Color.backgroundSecondary)
                .cornerRadius(PUI.Constant.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
//                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            }
            .padding(.horizontal)
        }
    }

    
}

// Пример использования
struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var bio: String = ""
    @State private var note: String = ""

    var body: some View {
        VStack(spacing: 20) {

            PUI.TextField(
                title: "Пароль",
                placeholder: "Введите пароль",
                type: .password,
                text: $password
            )

            PUI.TextField(
                title: "О себе",
                placeholder: "Расскажите о себе",
                type: .multiLine,
                text: $bio
            )

            PUI.TextField(
                title: "Заметка",
                placeholder: "Введите заметку",
                type: .singleLine,
                text: $note
            )
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

