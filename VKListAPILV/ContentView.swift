import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RepositoryListView()
            FPSOverlayView() 
        }
    }
}

#Preview {
    ContentView()
}
