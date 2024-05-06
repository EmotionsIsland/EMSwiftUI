// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum SFPro {
    internal static let black = FontConvertible(name: "SFPro-Black", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let bold = FontConvertible(name: "SFPro-Bold", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let compressedBlack = FontConvertible(name: "SFPro-CompressedBlack", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let compressedBold = FontConvertible(name: "SFPro-CompressedBold", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let compressedHeavy = FontConvertible(name: "SFPro-CompressedHeavy", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let compressedLight = FontConvertible(name: "SFPro-CompressedLight", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let compressedMedium = FontConvertible(name: "SFPro-CompressedMedium", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let compressedRegular = FontConvertible(name: "SFPro-CompressedRegular", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let compressedSemibold = FontConvertible(name: "SFPro-CompressedSemibold", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let compressedThin = FontConvertible(name: "SFPro-CompressedThin", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let compressedUltralight = FontConvertible(name: "SFPro-CompressedUltralight", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let condensedBlack = FontConvertible(name: "SFPro-CondensedBlack", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let condensedBold = FontConvertible(name: "SFPro-CondensedBold", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let condensedHeavy = FontConvertible(name: "SFPro-CondensedHeavy", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let condensedLight = FontConvertible(name: "SFPro-CondensedLight", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let condensedMedium = FontConvertible(name: "SFPro-CondensedMedium", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let condensedRegular = FontConvertible(name: "SFPro-CondensedRegular", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let condensedSemibold = FontConvertible(name: "SFPro-CondensedSemibold", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let condensedThin = FontConvertible(name: "SFPro-CondensedThin", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let condensedUltralight = FontConvertible(name: "SFPro-CondensedUltralight", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let expandedBlack = FontConvertible(name: "SFPro-ExpandedBlack", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let expandedBold = FontConvertible(name: "SFPro-ExpandedBold", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let expandedHeavy = FontConvertible(name: "SFPro-ExpandedHeavy", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let expandedLight = FontConvertible(name: "SFPro-ExpandedLight", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let expandedMedium = FontConvertible(name: "SFPro-ExpandedMedium", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let expandedRegular = FontConvertible(name: "SFPro-ExpandedRegular", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let expandedSemibold = FontConvertible(name: "SFPro-ExpandedSemibold", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let expandedThin = FontConvertible(name: "SFPro-ExpandedThin", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let expandedUltralight = FontConvertible(name: "SFPro-ExpandedUltralight", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let heavy = FontConvertible(name: "SFPro-Heavy", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let light = FontConvertible(name: "SFPro-Light", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let medium = FontConvertible(name: "SFPro-Medium", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let regular = FontConvertible(name: "SFPro-Regular", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let semibold = FontConvertible(name: "SFPro-Semibold", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let thin = FontConvertible(name: "SFPro-Thin", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let ultralight = FontConvertible(name: "SFPro-Ultralight", family: "SF Pro", path: "SF-Pro.ttf")
    internal static let all: [FontConvertible] = [black, bold, compressedBlack, compressedBold, compressedHeavy, compressedLight, compressedMedium, compressedRegular, compressedSemibold, compressedThin, compressedUltralight, condensedBlack, condensedBold, condensedHeavy, condensedLight, condensedMedium, condensedRegular, condensedSemibold, condensedThin, condensedUltralight, expandedBlack, expandedBold, expandedHeavy, expandedLight, expandedMedium, expandedRegular, expandedSemibold, expandedThin, expandedUltralight, heavy, light, medium, regular, semibold, thin, ultralight]
  }
  internal enum SFProText {
    internal static let black = FontConvertible(name: "SFProText-Black", family: "SF Pro Text", path: "SF-Pro-Text-Black.otf")
    internal static let bold = FontConvertible(name: "SFProText-Bold", family: "SF Pro Text", path: "SF-Pro-Text-Bold.otf")
    internal static let heavy = FontConvertible(name: "SFProText-Heavy", family: "SF Pro Text", path: "SF-Pro-Text-Heavy.otf")
    internal static let light = FontConvertible(name: "SFProText-Light", family: "SF Pro Text", path: "SF-Pro-Text-Light.otf")
    internal static let medium = FontConvertible(name: "SFProText-Medium", family: "SF Pro Text", path: "SF-Pro-Text-Medium.otf")
    internal static let regular = FontConvertible(name: "SFProText-Regular", family: "SF Pro Text", path: "SF-Pro-Text-Regular.otf")
    internal static let semibold = FontConvertible(name: "SFProText-Semibold", family: "SF Pro Text", path: "SF-Pro-Text-Semibold.otf")
    internal static let thin = FontConvertible(name: "SFProText-Thin", family: "SF Pro Text", path: "SF-Pro-Text-Thin.otf")
    internal static let ultralight = FontConvertible(name: "SFProText-Ultralight", family: "SF Pro Text", path: "SF-Pro-Text-Ultralight.otf")
    internal static let all: [FontConvertible] = [black, bold, heavy, light, medium, regular, semibold, thin, ultralight]
  }
  internal static let allCustomFonts: [FontConvertible] = [SFPro.all, SFProText.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  #if os(macOS)
  internal typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Font = UIFont
  #endif

  internal func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  internal func swiftUIFont(fixedSize: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, fixedSize: fixedSize)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  internal func swiftUIFont(size: CGFloat, relativeTo textStyle: SwiftUI.Font.TextStyle) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size, relativeTo: textStyle)
  }
  #endif

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate func registerIfNeeded() {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: family).contains(name) {
      register()
    }
    #elseif os(macOS)
    if let url = url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      register()
    }
    #endif
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    font.registerIfNeeded()
    self.init(name: font.name, size: size)
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, size: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size)
  }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
internal extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, fixedSize: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, fixedSize: fixedSize)
  }

  static func custom(
    _ font: FontConvertible,
    size: CGFloat,
    relativeTo textStyle: SwiftUI.Font.TextStyle
  ) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size, relativeTo: textStyle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
