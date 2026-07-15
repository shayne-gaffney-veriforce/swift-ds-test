import SwiftUI

/// Stands in for the not-yet-built OKTA/VF1 login. Picking an identity here plays the role that
/// authentication would otherwise play in production.
public struct RoleSwitcherView: View {
    @EnvironmentObject private var store: WorkerDirectoryStore
    @State private var actor: CurrentActor?

    public init() {}

    public var body: some View {
        if let actor {
            RootView(actor: actor, onSwitchRole: { self.actor = nil })
        } else {
            NavigationStack {
                List {
                    Section("Contractor admin") {
                        ForEach(store.contractors) { contractor in
                            Button(contractor.name) {
                                actor = .contractorAdmin(contractor)
                            }
                        }
                    }
                    Section("Worker (self-service)") {
                        ForEach(store.workers) { worker in
                            Button(worker.fullName) {
                                actor = .worker(worker)
                            }
                        }
                    }
                    Section("Internal") {
                        Button("Platform Admin") {
                            actor = .platformAdmin
                        }
                    }
                }
                .navigationTitle("Continue as…")
            }
        }
    }
}

private struct RootView: View {
    let actor: CurrentActor
    let onSwitchRole: () -> Void

    var body: some View {
        NavigationStack {
            Group {
                switch actor {
                case .contractorAdmin(let contractor):
                    WorkerRosterView(contractor: contractor)
                case .worker(let worker):
                    MyProfileView(workerID: worker.id)
                case .platformAdmin:
                    GlobalWorkerSearchView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Switch Role", action: onSwitchRole)
                }
            }
        }
    }
}
