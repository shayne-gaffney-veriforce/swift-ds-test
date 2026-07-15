import SwiftUI

/// Transcribed from "Settings / Edit Profile": profile photo + "Replace photo", then
/// name/contact/address field groups, and a "Save changes" bottom button.
public struct EditProfileView: View {
    @EnvironmentObject private var store: AppStore
    @Environment(\.dismiss) private var dismiss

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var jobTitle = ""
    @State private var email = ""
    @State private var username = ""
    @State private var phone = ""
    @State private var extensionNumber = ""
    @State private var address = ""
    @State private var city = ""
    @State private var postalCode = ""
    @State private var country = ""

    public init() {}

    public var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    VStack(spacing: SCSpacing.small) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 96, height: 96)
                            .foregroundStyle(SCColor.textTertiary)
                        Label("Replace photo", systemImage: "camera")
                            .font(SCTypography.body1)
                            .foregroundStyle(SCBlue._600)
                    }
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }

            Section("Name") {
                TextField("First name", text: $firstName)
                TextField("Last name", text: $lastName)
                TextField("Job Title", text: $jobTitle)
            }

            Section("Contact") {
                TextField("Email Address", text: $email)
                    #if os(iOS)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    #endif
                TextField("Username", text: $username)
                TextField("Phone", text: $phone)
                TextField("Extension", text: $extensionNumber)
            }

            Section("Address") {
                TextField("Address", text: $address)
                TextField("City", text: $city)
                TextField("Post Code", text: $postalCode)
                TextField("Country", text: $country)
            }
        }
        .navigationTitle("Edit Profile")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save Changes", action: save)
            }
        }
        .onAppear(perform: loadFromProfile)
    }

    private func loadFromProfile() {
        firstName = store.profile.firstName
        lastName = store.profile.lastName
        jobTitle = store.profile.jobTitle
        email = store.profile.email
        username = store.profile.username
        phone = store.profile.phone
        extensionNumber = store.profile.extensionNumber
        address = store.profile.address
        city = store.profile.city
        postalCode = store.profile.postalCode
        country = store.profile.country
    }

    private func save() {
        store.profile.firstName = firstName
        store.profile.lastName = lastName
        store.profile.jobTitle = jobTitle
        store.profile.email = email
        store.profile.username = username
        store.profile.phone = phone
        store.profile.extensionNumber = extensionNumber
        store.profile.address = address
        store.profile.city = city
        store.profile.postalCode = postalCode
        store.profile.country = country
        dismiss()
    }
}
