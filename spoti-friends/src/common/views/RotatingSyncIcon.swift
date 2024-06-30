import SwiftUI

/// Returns a sync icon that rotates when tapped.
///
/// - Parameters:
///   - width: The width of the icon.
///   - color: The color of the icon.
///
/// - Returns: A View containing a sync icon that rotates when tapped.
struct RotatingSyncIcon: View {
    @State private var rotation: Double = 0
    let width: CGFloat
    let color: Color
    
    var body: some View {
        Image(systemName: "arrow.triangle.2.circlepath")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width)
            .foregroundStyle(color)
            .rotationEffect(.degrees(rotation))
            .onTapGesture {
                withAnimation(.easeOut(duration: 0.6)) {
                    rotation += 360
                }
            }
    }
}

#Preview {
    RotatingSyncIcon(width: 96, color: Color.black)
}
