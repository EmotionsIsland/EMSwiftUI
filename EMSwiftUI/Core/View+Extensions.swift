import SwiftUI
import Foundation

extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

// extension View {
//  func readSize(id: String, onChange: @escaping (CGSize) -> Void) -> some View {
//    background(
//      GeometryReader { geometryProxy in
//        Color.clear
//          .preference(key: SizePreferenceKey.self, value: [id: geometryProxy.size])
//      }
//    )
//    .onPreferenceChange(SizePreferenceKey.self) { preferences in
//      if let size = preferences[id] {
//        onChange(size)
//      }
//    }
//  }
// }
//
//
// struct SizePreferenceKey: PreferenceKey {
//  static var defaultValue: [String: CGSize] = [:]
//
//  static func reduce(value: inout [String: CGSize], nextValue: () -> [String: CGSize]) {
//    value.merge(nextValue(), uniquingKeysWith: { $1 })
//  }
// }
