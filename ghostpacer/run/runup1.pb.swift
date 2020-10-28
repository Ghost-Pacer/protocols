// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: runup1.proto
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

struct Ghostpacer_Run_UploadedRun {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var totalDistance: Float = 0

  var startTime: Float = 0

  var startLat: Float = 0

  var startLon: Float = 0

  var trackStartPoint: Ghostpacer_Run_TrackStartPoint = .p0

  var compLatDist: [Float] = []

  var compLat: [Float] = []

  var compLonDist: [Float] = []

  var compLon: [Float] = []

  var savedTime: [Float] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "ghostpacer.run"

extension Ghostpacer_Run_UploadedRun: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".UploadedRun"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "totalDistance"),
    2: .same(proto: "startTime"),
    3: .same(proto: "startLat"),
    4: .same(proto: "startLon"),
    5: .same(proto: "trackStartPoint"),
    6: .same(proto: "compLatDist"),
    7: .same(proto: "compLat"),
    8: .same(proto: "compLonDist"),
    9: .same(proto: "compLon"),
    10: .same(proto: "savedTime"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularFloatField(value: &self.totalDistance) }()
      case 2: try { try decoder.decodeSingularFloatField(value: &self.startTime) }()
      case 3: try { try decoder.decodeSingularFloatField(value: &self.startLat) }()
      case 4: try { try decoder.decodeSingularFloatField(value: &self.startLon) }()
      case 5: try { try decoder.decodeSingularEnumField(value: &self.trackStartPoint) }()
      case 6: try { try decoder.decodeRepeatedFloatField(value: &self.compLatDist) }()
      case 7: try { try decoder.decodeRepeatedFloatField(value: &self.compLat) }()
      case 8: try { try decoder.decodeRepeatedFloatField(value: &self.compLonDist) }()
      case 9: try { try decoder.decodeRepeatedFloatField(value: &self.compLon) }()
      case 10: try { try decoder.decodeRepeatedFloatField(value: &self.savedTime) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.totalDistance != 0 {
      try visitor.visitSingularFloatField(value: self.totalDistance, fieldNumber: 1)
    }
    if self.startTime != 0 {
      try visitor.visitSingularFloatField(value: self.startTime, fieldNumber: 2)
    }
    if self.startLat != 0 {
      try visitor.visitSingularFloatField(value: self.startLat, fieldNumber: 3)
    }
    if self.startLon != 0 {
      try visitor.visitSingularFloatField(value: self.startLon, fieldNumber: 4)
    }
    if self.trackStartPoint != .p0 {
      try visitor.visitSingularEnumField(value: self.trackStartPoint, fieldNumber: 5)
    }
    if !self.compLatDist.isEmpty {
      try visitor.visitPackedFloatField(value: self.compLatDist, fieldNumber: 6)
    }
    if !self.compLat.isEmpty {
      try visitor.visitPackedFloatField(value: self.compLat, fieldNumber: 7)
    }
    if !self.compLonDist.isEmpty {
      try visitor.visitPackedFloatField(value: self.compLonDist, fieldNumber: 8)
    }
    if !self.compLon.isEmpty {
      try visitor.visitPackedFloatField(value: self.compLon, fieldNumber: 9)
    }
    if !self.savedTime.isEmpty {
      try visitor.visitPackedFloatField(value: self.savedTime, fieldNumber: 10)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Ghostpacer_Run_UploadedRun, rhs: Ghostpacer_Run_UploadedRun) -> Bool {
    if lhs.totalDistance != rhs.totalDistance {return false}
    if lhs.startTime != rhs.startTime {return false}
    if lhs.startLat != rhs.startLat {return false}
    if lhs.startLon != rhs.startLon {return false}
    if lhs.trackStartPoint != rhs.trackStartPoint {return false}
    if lhs.compLatDist != rhs.compLatDist {return false}
    if lhs.compLat != rhs.compLat {return false}
    if lhs.compLonDist != rhs.compLonDist {return false}
    if lhs.compLon != rhs.compLon {return false}
    if lhs.savedTime != rhs.savedTime {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}