// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: rundown1.proto
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

struct Ghostpacer_Run_DownloadedRun {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var name: String = String()

  var startLat: Float = 0

  var startLon: Float = 0

  var mileSplit: Float = 0

  var trackStartPoint: Ghostpacer_Run_TrackStartPoint = .none

  var pointLat: [Float] = []

  var pointLon: [Float] = []

  var pointElev: [Float] = []

  var savedTime: [Float] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "ghostpacer.run"

extension Ghostpacer_Run_DownloadedRun: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".DownloadedRun"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "name"),
    2: .same(proto: "startLat"),
    3: .same(proto: "startLon"),
    4: .same(proto: "mileSplit"),
    5: .same(proto: "trackStartPoint"),
    6: .same(proto: "pointLat"),
    7: .same(proto: "pointLon"),
    8: .same(proto: "pointElev"),
    9: .same(proto: "savedTime"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 2: try { try decoder.decodeSingularFloatField(value: &self.startLat) }()
      case 3: try { try decoder.decodeSingularFloatField(value: &self.startLon) }()
      case 4: try { try decoder.decodeSingularFloatField(value: &self.mileSplit) }()
      case 5: try { try decoder.decodeSingularEnumField(value: &self.trackStartPoint) }()
      case 6: try { try decoder.decodeRepeatedFloatField(value: &self.pointLat) }()
      case 7: try { try decoder.decodeRepeatedFloatField(value: &self.pointLon) }()
      case 8: try { try decoder.decodeRepeatedFloatField(value: &self.pointElev) }()
      case 9: try { try decoder.decodeRepeatedFloatField(value: &self.savedTime) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 1)
    }
    if self.startLat != 0 {
      try visitor.visitSingularFloatField(value: self.startLat, fieldNumber: 2)
    }
    if self.startLon != 0 {
      try visitor.visitSingularFloatField(value: self.startLon, fieldNumber: 3)
    }
    if self.mileSplit != 0 {
      try visitor.visitSingularFloatField(value: self.mileSplit, fieldNumber: 4)
    }
    if self.trackStartPoint != .none {
      try visitor.visitSingularEnumField(value: self.trackStartPoint, fieldNumber: 5)
    }
    if !self.pointLat.isEmpty {
      try visitor.visitPackedFloatField(value: self.pointLat, fieldNumber: 6)
    }
    if !self.pointLon.isEmpty {
      try visitor.visitPackedFloatField(value: self.pointLon, fieldNumber: 7)
    }
    if !self.pointElev.isEmpty {
      try visitor.visitPackedFloatField(value: self.pointElev, fieldNumber: 8)
    }
    if !self.savedTime.isEmpty {
      try visitor.visitPackedFloatField(value: self.savedTime, fieldNumber: 9)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Ghostpacer_Run_DownloadedRun, rhs: Ghostpacer_Run_DownloadedRun) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.startLat != rhs.startLat {return false}
    if lhs.startLon != rhs.startLon {return false}
    if lhs.mileSplit != rhs.mileSplit {return false}
    if lhs.trackStartPoint != rhs.trackStartPoint {return false}
    if lhs.pointLat != rhs.pointLat {return false}
    if lhs.pointLon != rhs.pointLon {return false}
    if lhs.pointElev != rhs.pointElev {return false}
    if lhs.savedTime != rhs.savedTime {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
