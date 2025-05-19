import SwiftUI

struct SplashScreen: View {
    var body: some View {
        RootView()
    }
}

struct RootView: View {
    @State private var showMainView = false

    var body: some View {
        if showMainView {
            MainView()
        } else {
            SplashScreen2(showMainView: $showMainView)
        }
    }
}

struct SplashScreen2: View {
    @Binding var showMainView: Bool

    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0.0
    @State private var textOpacity: Double = 0.0

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack {
                Spacer(minLength: 60)

                VStack(spacing: 12) {
                    Image("tm1_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .opacity(logoOpacity)
                        .scaleEffect(logoScale)
                        .shadow(color: Color.gray.opacity(0.3), radius: 20)
                        .onAppear {
                            withAnimation(.easeOut(duration: 1.0)) {
                                logoOpacity = 1.0
                                logoScale = 1.05
                            }
                            withAnimation(.easeInOut(duration: 1.2).delay(1.0).repeatCount(2, autoreverses: true)) {
                                logoScale = 1.1
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
                                withAnimation(.easeOut(duration: 0.3)) {
                                    logoScale = 1.0
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                                withAnimation(.easeOut(duration: 1.0)) {
                                    textOpacity = 1.0
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                                withAnimation {
                                    showMainView = true
                                }
                            }
                        }

                    VStack(spacing: 6) {
                        ZStack {
                            Text("Theorem One")
                                .font(.system(size: 34, weight: .bold, design: .rounded))
                                .foregroundColor(Color(hex: "#5AB074"))
                                .shadow(color: Color.gray.opacity(0.3), radius: 6)
                                .opacity(textOpacity)
                                .scaleEffect(textOpacity == 1 ? 1.0 : 0.8)

                            if textOpacity == 1.0 {
                                ShimmerTextOverlay()
                            }
                        }

                        Text("Design a Life Resilient to Burn Out")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .opacity(textOpacity)
                    }
                    .padding(.top, 16)
                }

                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct ShimmerTextOverlay: View {
    @State private var shimmerOffset: CGFloat = -250

    var body: some View {
        Text("Theorem One")
            .font(.system(size: 34, weight: .bold, design: .rounded))
            .foregroundColor(.clear)
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.0),
                        Color.white.opacity(0.8),
                        Color.white.opacity(0.0)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .rotationEffect(.degrees(30))
                .offset(x: shimmerOffset)
                .mask(
                    Text("Theorem One")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                )
            )
            .onAppear {
                withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: false)) {
                    shimmerOffset = 250
                }
            }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

struct MainView: View {
    var body: some View {
        ContentView()    }
}

#Preview {
    SplashScreen()
}
