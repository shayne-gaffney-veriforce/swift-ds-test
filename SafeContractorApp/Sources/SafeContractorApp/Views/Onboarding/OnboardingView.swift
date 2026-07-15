import SwiftUI

struct OnboardingStep {
    let imageName: String
    let title: String
    let description: String
}

/// The 4-step onboarding carousel — content transcribed verbatim from "Onboarding 1b"–"4b" in the
/// Figma file.
public struct OnboardingView: View {
    public let onFinished: () -> Void

    @State private var stepIndex = 0

    private let steps: [OnboardingStep] = [
        OnboardingStep(imageName: "Onboarding1", title: "Complete your\ne-learning courses", description: "Start and continue your e-learning courses on the go"),
        OnboardingStep(imageName: "Onboarding2", title: "Scan your code for easy gate access", description: "Get easy access to hiring client sites with your personal QR code"),
        OnboardingStep(imageName: "Onboarding3", title: "Check your training & qualifications", description: "Easily access your professional file to see your achievements"),
        OnboardingStep(imageName: "Onboarding4", title: "Keep up to date on announcements", description: "Receive important announcements and news from hiring clients")
    ]

    public init(onFinished: @escaping () -> Void) {
        self.onFinished = onFinished
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            Image(steps[stepIndex].imageName, bundle: .module)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: SCSpacing.large) {
                Image("LogoWhite", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220)

                VStack(alignment: .leading, spacing: SCSpacing.small) {
                    Text(steps[stepIndex].title)
                        .font(SCTypography.h2)
                    Text(steps[stepIndex].description)
                        .font(SCTypography.subtitle1)
                }
                .foregroundStyle(SCColor.textInverse)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(SCSpacing.standard)
                .background(SCBlue._800)
                .clipShape(RoundedRectangle(cornerRadius: SCRadius.card))

                VStack(spacing: SCSpacing.standard) {
                    Button(stepIndex == steps.count - 1 ? "Let's go!" : "Next") {
                        if stepIndex == steps.count - 1 {
                            onFinished()
                        } else {
                            stepIndex += 1
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(SCColor.primary)
                    .frame(maxWidth: .infinity)

                    HStack(spacing: 6) {
                        ForEach(steps.indices, id: \.self) { index in
                            Capsule()
                                .fill(index == stepIndex ? Color.white : Color.white.opacity(0.4))
                                .frame(width: index == stepIndex ? 20 : 6, height: 6)
                        }
                    }
                }
            }
            .padding(.horizontal, SCSpacing.standard)
            .padding(.bottom, SCSpacing.large)
        }
    }
}
