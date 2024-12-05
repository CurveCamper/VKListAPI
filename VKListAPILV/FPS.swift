import SwiftUI

class FPSMonitor: ObservableObject {
    @Published var fps: Int = 0
    
    private var displayLink: CADisplayLink?
    private var lastUpdateTime: CFTimeInterval = 0
    private var frameCount: Int = 0
    
    init() {
        startMonitoring()
    }
    
    deinit {
        stopMonitoring()
    }
    
    private func startMonitoring() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateFPS))
        displayLink?.add(to: .main, forMode: .common)
    }
    
    private func stopMonitoring() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func updateFPS(link: CADisplayLink) {
        guard lastUpdateTime != 0 else {
            lastUpdateTime = link.timestamp
            return
        }
        
        frameCount += 1
        let elapsedTime = link.timestamp - lastUpdateTime
        
        if elapsedTime >= 1.0 {
            fps = frameCount
            frameCount = 0
            lastUpdateTime = link.timestamp
        }
    }
}

struct FPSOverlayView: View {
    @StateObject private var fpsMonitor = FPSMonitor()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(fpsMonitor.fps) FPS")
                    .font(.caption)
                    .padding(4)
                    .background(Color.black.opacity(0.6))
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .padding(.trailing, 10)
                    .padding(.top, 5)
            }
            Spacer()
        }
        .allowsHitTesting(false)
    }
}
