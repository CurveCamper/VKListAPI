import SwiftUI

struct RepositoryRowView: View {
    let repository: Repository

    var body: some View {
        HStack(alignment: .top, spacing: 20) {

            AsyncImage(url: URL(string: repository.owner.avatar_url)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 40, height: 40)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                case .failure:
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(repository.name)
                    .font(.headline)

                if let description = repository.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .scrollContentBackground(.hidden)
    }
}
