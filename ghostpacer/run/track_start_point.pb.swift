// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: track_start_point.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

enum Ghostpacer_Run_TrackStartPoint: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case none // = 0
  case p1 // = 1
  case p2 // = 2
  case p3 // = 3
  case p4 // = 4
  case UNRECOGNIZED(Int)

  init() {
    self = .none
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .none
    case 1: self = .p1
    case 2: self = .p2
    case 3: self = .p3
    case 4: self = .p4
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .none: return 0
    case .p1: return 1
    case .p2: return 2
    case .p3: return 3
    case .p4: return 4
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Ghostpacer_Run_TrackStartPoint: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Ghostpacer_Run_TrackStartPoint] = [
    .none,
    .p1,
    .p2,
    .p3,
    .p4,
  ]
}

#endif  // swift(>=4.2)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension Ghostpacer_Run_TrackStartPoint: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "NONE"),
    1: .same(proto: "P1"),
    2: .same(proto: "P2"),
    3: .same(proto: "P3"),
    4: .same(proto: "P4"),
  ]
}
