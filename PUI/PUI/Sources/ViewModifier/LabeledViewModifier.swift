import SwiftUI

public struct LabeledViewModifier: ViewModifier {

    let title: LocalizedStringKey

    public func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: PUI.Spacing.small) {
            Text(title)
                .font(PUI.Font.text)
                .foregroundStyle(Color.pui.textPrimary)
                .padding(.leading, PUI.Spacing.medium)

            content
        }
    }
}

public extension View {
    func labeled(_ title: LocalizedStringKey) -> some View {
        modifier(
            LabeledViewModifier(title: title)
        )
    }
}
