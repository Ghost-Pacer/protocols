// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.25.0-devel
// 	protoc        v3.6.1
// source: track_start_point.proto

package runproto

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

type TrackStartPoint int32

const (
	TrackStartPoint_NONE TrackStartPoint = 0
	TrackStartPoint_P1   TrackStartPoint = 1
	TrackStartPoint_P2   TrackStartPoint = 2
	TrackStartPoint_P3   TrackStartPoint = 3
	TrackStartPoint_P4   TrackStartPoint = 4
)

// Enum value maps for TrackStartPoint.
var (
	TrackStartPoint_name = map[int32]string{
		0: "NONE",
		1: "P1",
		2: "P2",
		3: "P3",
		4: "P4",
	}
	TrackStartPoint_value = map[string]int32{
		"NONE": 0,
		"P1":   1,
		"P2":   2,
		"P3":   3,
		"P4":   4,
	}
)

func (x TrackStartPoint) Enum() *TrackStartPoint {
	p := new(TrackStartPoint)
	*p = x
	return p
}

func (x TrackStartPoint) String() string {
	return protoimpl.X.EnumStringOf(x.Descriptor(), protoreflect.EnumNumber(x))
}

func (TrackStartPoint) Descriptor() protoreflect.EnumDescriptor {
	return file_track_start_point_proto_enumTypes[0].Descriptor()
}

func (TrackStartPoint) Type() protoreflect.EnumType {
	return &file_track_start_point_proto_enumTypes[0]
}

func (x TrackStartPoint) Number() protoreflect.EnumNumber {
	return protoreflect.EnumNumber(x)
}

// Deprecated: Use TrackStartPoint.Descriptor instead.
func (TrackStartPoint) EnumDescriptor() ([]byte, []int) {
	return file_track_start_point_proto_rawDescGZIP(), []int{0}
}

var File_track_start_point_proto protoreflect.FileDescriptor

var file_track_start_point_proto_rawDesc = []byte{
	0x0a, 0x17, 0x74, 0x72, 0x61, 0x63, 0x6b, 0x5f, 0x73, 0x74, 0x61, 0x72, 0x74, 0x5f, 0x70, 0x6f,
	0x69, 0x6e, 0x74, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x12, 0x0e, 0x67, 0x68, 0x6f, 0x73, 0x74,
	0x70, 0x61, 0x63, 0x65, 0x72, 0x2e, 0x72, 0x75, 0x6e, 0x2a, 0x3b, 0x0a, 0x0f, 0x54, 0x72, 0x61,
	0x63, 0x6b, 0x53, 0x74, 0x61, 0x72, 0x74, 0x50, 0x6f, 0x69, 0x6e, 0x74, 0x12, 0x08, 0x0a, 0x04,
	0x4e, 0x4f, 0x4e, 0x45, 0x10, 0x00, 0x12, 0x06, 0x0a, 0x02, 0x50, 0x31, 0x10, 0x01, 0x12, 0x06,
	0x0a, 0x02, 0x50, 0x32, 0x10, 0x02, 0x12, 0x06, 0x0a, 0x02, 0x50, 0x33, 0x10, 0x03, 0x12, 0x06,
	0x0a, 0x02, 0x50, 0x34, 0x10, 0x04, 0x42, 0x3d, 0x5a, 0x3b, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62,
	0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x47, 0x68, 0x6f, 0x73, 0x74, 0x2d, 0x50, 0x61, 0x63, 0x65, 0x72,
	0x2f, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x63, 0x6f, 0x6c, 0x73, 0x2f, 0x67, 0x68, 0x6f, 0x73, 0x74,
	0x70, 0x61, 0x63, 0x65, 0x72, 0x2f, 0x72, 0x75, 0x6e, 0x2f, 0x67, 0x6f, 0x2f, 0x72, 0x75, 0x6e,
	0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x06, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_track_start_point_proto_rawDescOnce sync.Once
	file_track_start_point_proto_rawDescData = file_track_start_point_proto_rawDesc
)

func file_track_start_point_proto_rawDescGZIP() []byte {
	file_track_start_point_proto_rawDescOnce.Do(func() {
		file_track_start_point_proto_rawDescData = protoimpl.X.CompressGZIP(file_track_start_point_proto_rawDescData)
	})
	return file_track_start_point_proto_rawDescData
}

var file_track_start_point_proto_enumTypes = make([]protoimpl.EnumInfo, 1)
var file_track_start_point_proto_goTypes = []interface{}{
	(TrackStartPoint)(0), // 0: ghostpacer.run.TrackStartPoint
}
var file_track_start_point_proto_depIdxs = []int32{
	0, // [0:0] is the sub-list for method output_type
	0, // [0:0] is the sub-list for method input_type
	0, // [0:0] is the sub-list for extension type_name
	0, // [0:0] is the sub-list for extension extendee
	0, // [0:0] is the sub-list for field type_name
}

func init() { file_track_start_point_proto_init() }
func file_track_start_point_proto_init() {
	if File_track_start_point_proto != nil {
		return
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_track_start_point_proto_rawDesc,
			NumEnums:      1,
			NumMessages:   0,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_track_start_point_proto_goTypes,
		DependencyIndexes: file_track_start_point_proto_depIdxs,
		EnumInfos:         file_track_start_point_proto_enumTypes,
	}.Build()
	File_track_start_point_proto = out.File
	file_track_start_point_proto_rawDesc = nil
	file_track_start_point_proto_goTypes = nil
	file_track_start_point_proto_depIdxs = nil
}
