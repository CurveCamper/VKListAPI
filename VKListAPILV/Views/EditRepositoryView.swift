import SwiftUI

struct EditRepositoryView: View {
    @Environment(\.dismiss) private var dismiss
    let repository: Repository
    var onSave: (String, String?) -> Void

    @State private var name: String
    @State private var description: String?

    init(repository: Repository, onSave: @escaping (String, String?) -> Void) {
        self.repository = repository
        self.onSave = onSave
        _name = State(initialValue: repository.name)
        _description = State(initialValue: repository.description)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Repository Name", text: $name)
                }
                Section(header: Text("Description")) {
                    TextField("Repository Description", text: $description.bound)
                }
            }
            .navigationTitle("Edit Repository")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(name, description)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        name = repository.name
                        description = repository.description
                        dismiss()
                    }
                }
            }
        }
    }
}

