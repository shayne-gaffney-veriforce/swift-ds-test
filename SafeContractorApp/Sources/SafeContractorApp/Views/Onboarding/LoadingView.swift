import SwiftUI

public struct LoadingView: View {
    public let onFinished: () -> Void

    public init(onFinished: @escaping () -> Void) {
        self.onFinished = onFinished
    }

    public var body: some View {
        VStack(spacing: SCSpacing.large) {
            Spacer()
            Image("LogoWhite", bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(width: 220)
            Spacer()
            VStack(spacing: 4) {
                Text("v 2.0.0")
                Text("www.safecontractor.com")
            }
            .font(SCTypography.subtitle2)
            .foregroundStyle(SCColor.textInverse)
            .padding(.bottom, SCSpacing.large)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SCColor.brandNavy)
        .task {
            try? await Task.sleep(nanoseconds: 1_200_000_000)
            onFinished()
        }
    }
}
