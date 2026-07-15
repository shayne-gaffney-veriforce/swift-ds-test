import SwiftUI

/// Transcribed from "Settings / Company name": a searchable list of hiring clients, with a note
/// that client corporations are starred.
public struct CompanyNameView: View {
    @State private var searchText = ""

    private let companies = ["Alcoa", "United Rentals", "Hydro Quebec", "Bombardier", "Alcumus SafeContractor"]

    public init() {}

    private var filtered: [String] {
        companies.filter { searchText.isEmpty || $0.localizedCaseInsensitiveContains(searchText) }
    }

    public var body: some View {
        List {
            Section {
                ForEach(filtered, id: \.self) { name in
                    Text(name)
                }
            } footer: {
                Text("Companies marked with a star * are client corporations")
            }
        }
        .searchable(text: $searchText, prompt: "Search")
        .navigationTitle("Company Name")
    }
}
