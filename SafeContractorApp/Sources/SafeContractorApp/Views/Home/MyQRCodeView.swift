import SwiftUI

/// Transcribed from "Home / My QR code": full-bleed brand navy, logo, a large QR code card, the
/// worker's name and card ID, and an "Add to Apple Wallet" action.
public struct MyQRCodeView: View {
    @EnvironmentObject private var store: AppStore
    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        NavigationStack {
            VStack(spacing: SCSpacing.large) {
                Spacer()

                Image("LogoWhite", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180)

                VStack(spacing: SCSpacing.medium) {
                    Image(systemName: "qrcode")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .padding(SCSpacing.standard)
                        .background(SCColor.textInverse)
                        .clipShape(RoundedRectangle(cornerRadius: SCRadius.card))

                    VStack(spacing: 4) {
                        Text(store.profile.fullName)
                            .font(SCTypography.h2)
                        Text(store.profile.workerCardID)
                            .font(SCTypography.subtitle1)
                    }
                    .foregroundStyle(SCColor.textInverse)
                }

                Button {
                    // Apple Wallet integration is out of scope for this prototype.
                } label: {
                    Label("Add to Apple Wallet", systemImage: "wallet.pass")
                }
                .buttonStyle(.bordered)
                .tint(SCColor.textInverse)

                Spacer()
            }
            .padding(SCSpacing.standard)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(SCColor.brandNavy)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .tint(SCColor.textInverse)
                }
            }
        }
    }
}
