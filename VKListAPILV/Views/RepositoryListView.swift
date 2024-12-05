import SwiftUI

struct RepositoryListView: View {
    @StateObject private var viewModel = RepositoryViewModel()
    @State private var showEditSheet = false
    @State private var repositoryToEdit: Repository?

    var body: some View {
        NavigationView {
            VStack {
                Picker("Sort By", selection: $viewModel.sortOption) {
                    ForEach(SortOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.repositories.indices, id: \.self) { index in
                            let repo = viewModel.repositories[index]
                            NavigationLink(destination: RepositoryDetailView(viewModel: viewModel, repository: repo)) {
                                RepositoryRowView(repository: repo)
                                    .padding()
                                    .background(Color(.secondarySystemBackground))
                                    .cornerRadius(8)
                                    .shadow(radius: 4)
                            }
                            .onAppear {
                                if index == viewModel.repositories.count - 1 {
                                    viewModel.fetchRepositories()
                                }
                            }
                        }


                        if viewModel.isLoading {
                            ProgressView()
                                .padding()
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .sheet(isPresented: $showEditSheet) {
                if let repositoryToEdit = repositoryToEdit {
                    EditRepositoryView(repository: repositoryToEdit) { updatedName, updatedDescription in
                        viewModel.updateRepository(repositoryToEdit, newName: updatedName, newDescription: updatedDescription)
                    }
                }
            }
            .onAppear {
                viewModel.fetchRepositories()
            }
            .navigationTitle("Repositories")
        }
    }
}
