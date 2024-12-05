import SwiftUI

struct RepositoryDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: RepositoryViewModel
    @State private var isEditing = false

    let repository: Repository

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            AsyncImage(url: URL(string: repository.owner.avatar_url)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 140, height: 140)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                case .failure:
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 140, height: 140)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(repository.name)
                .font(.largeTitle)
                .fontWeight(.bold)

            if let description = repository.description {
                Text(description)
                    .font(.body)
                    .foregroundColor(.gray)
            }

            Spacer()

            Button {
                isEditing = true
            } label: {
                Text("Edit Repository")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            
            Button(role: .destructive) {
                viewModel.deleteRepository(repository)
                dismiss()
            } label: {
                Text("Delete Repository")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .sheet(isPresented: $isEditing) {
            EditRepositoryView(repository: repository) { updatedName, updatedDescription in
                viewModel.updateRepository(repository, newName: updatedName, newDescription: updatedDescription)
            }
        }
    }
}
