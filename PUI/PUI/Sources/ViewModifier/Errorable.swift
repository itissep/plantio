import SwiftUI

fileprivate enum Constants {
    static let height: CGFloat = 42
    static let verticalInset: CGFloat = PUI.Spacing.small
    static let horizontalInset: CGFloat = PUI.Spacing.large
    
    static let errorOpacity: CGFloat = 0.1
}

struct FormErrorableItemViewModifier: ViewModifier {

    var message: String?
    var isErrorShowed: Bool

    func body(content: Content) -> some View {
        content
            .formTextFieldStyle()
            .formItemBackground(isErrorShowed ? .error : .default)
            .errorFooter(message: message, isShowed: isErrorShowed)
    }
}

public extension View {
    func formItem(
        errorMessage: String? = nil,
        isErrorShowed: Bool = false
    ) -> some View {
        modifier(FormErrorableItemViewModifier(
            message: errorMessage,
            isErrorShowed: isErrorShowed
        ))
    }
}


// MARK: TextStyle

struct FormTextFieldStyle: TextFieldStyle {

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(height: Constants.height)
            .padding(.horizontal, Constants.horizontalInset)
            .padding(.vertical, Constants.verticalInset)
    }

    
}

public extension View {
    func formTextFieldStyle() -> some View {
        textFieldStyle(FormTextFieldStyle())
    }
}

// MARK: Background

public struct FormItemBackgroundViewModifier: ViewModifier {

    public enum Style {
        case `default`
        case error

        var tintColor: Color {
            switch self {
            case .default: .pui.accent
            case .error: .gray
            }
        }

        var borderColor: Color {
            switch self {
            case .default: .clear
            case .error: .red
            }
        }

        var backgroundColor: Color {
            switch self {
            case .default: .pui.backgroundSecondary
            case .error: .red.opacity(Constants.errorOpacity)
            }
        }
    }

    let style: Style

    public func body(content: Content) -> some View {
        content
            .tint(style.tintColor)
            .background(background)
    }

    @ViewBuilder
    private var background: some View {
        RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
            .stroke(style.borderColor)
            .background(
                RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
                    .fill(style.backgroundColor)
            )
            .frame(minHeight: 42)
    }
}

public extension View {
    func formItemBackground(_ style: FormItemBackgroundViewModifier.Style = .default) -> some View {
        modifier(FormItemBackgroundViewModifier(style: style))
    }
}

// MARK: Error footer

struct ErrorFooterViewModifier: ViewModifier {

    var message: String?
    var isShowed: Bool

    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content

            if isShowed, message?.isEmpty == false {
                Text(LocalizedStringKey(message ?? ""))
                    .font(.callout)
                    .foregroundStyle(.red)
                    .animation(.bouncy, value: message)
            }
        }
    }
}

public extension View {
    func errorFooter(message: String?, isShowed: Bool) -> some View {
        modifier(ErrorFooterViewModifier(message: message, isShowed: isShowed))
    }
}
