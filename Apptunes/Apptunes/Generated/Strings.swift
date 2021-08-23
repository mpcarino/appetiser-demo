// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum APIs {
    internal enum Path {
      /// search?term=star&amp;country=au&amp;media=movie&amp;all
      internal static let search = L10n.tr("APIs", "path.search")
    }
    internal enum Url {
      /// https://itunes.apple.com/
      internal static let root = L10n.tr("APIs", "url.root")
    }
  }
  internal enum Literals {
    internal enum Error {
      internal enum Api {
        /// Sorry, we are unable to process your request right now. Please try again.
        internal static let message = L10n.tr("Literals", "error.api.message")
        /// Error Occured
        internal static let title = L10n.tr("Literals", "error.api.title")
      }
    }
    internal enum Symbol {
      /// 🔵
      internal static let blueCircle = L10n.tr("Literals", "symbol.blueCircle")
      /// ✅
      internal static let check = L10n.tr("Literals", "symbol.check")
      /// 🟢
      internal static let greenCircle = L10n.tr("Literals", "symbol.greenCircle")
      /// 🟠
      internal static let orangeCircle = L10n.tr("Literals", "symbol.orangeCircle")
      /// 🔴
      internal static let redCircle = L10n.tr("Literals", "symbol.redCircle")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

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
