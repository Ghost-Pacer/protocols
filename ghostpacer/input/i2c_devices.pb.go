// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.25.0-devel
// 	protoc        v3.6.1
// source: i2c_devices.proto

package ghostpacer_input

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	timestamppb "google.golang.org/protobuf/types/known/timestamppb"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

type InputEventTimings struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	PeripheralTime *timestamppb.Timestamp `protobuf:"bytes,1,opt,name=peripheral_time,json=peripheralTime,proto3" json:"peripheral_time,omitempty"`
	PackedTime     *timestamppb.Timestamp `protobuf:"bytes,2,opt,name=packed_time,json=packedTime,proto3" json:"packed_time,omitempty"`
	UnpackedTime   *timestamppb.Timestamp `protobuf:"bytes,3,opt,name=unpacked_time,json=unpackedTime,proto3" json:"unpacked_time,omitempty"`
}

func (x *InputEventTimings) Reset() {
	*x = InputEventTimings{}
	if protoimpl.UnsafeEnabled {
		mi := &file_i2c_devices_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *InputEventTimings) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*InputEventTimings) ProtoMessage() {}

func (x *InputEventTimings) ProtoReflect() protoreflect.Message {
	mi := &file_i2c_devices_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use InputEventTimings.ProtoReflect.Descriptor instead.
func (*InputEventTimings) Descriptor() ([]byte, []int) {
	return file_i2c_devices_proto_rawDescGZIP(), []int{0}
}

func (x *InputEventTimings) GetPeripheralTime() *timestamppb.Timestamp {
	if x != nil {
		return x.PeripheralTime
	}
	return nil
}

func (x *InputEventTimings) GetPackedTime() *timestamppb.Timestamp {
	if x != nil {
		return x.PackedTime
	}
	return nil
}

func (x *InputEventTimings) GetUnpackedTime() *timestamppb.Timestamp {
	if x != nil {
		return x.UnpackedTime
	}
	return nil
}

type Vec3 struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	X float64 `protobuf:"fixed64,1,opt,name=x,proto3" json:"x,omitempty"`
	Y float64 `protobuf:"fixed64,2,opt,name=y,proto3" json:"y,omitempty"`
	Z float64 `protobuf:"fixed64,3,opt,name=z,proto3" json:"z,omitempty"`
}

func (x *Vec3) Reset() {
	*x = Vec3{}
	if protoimpl.UnsafeEnabled {
		mi := &file_i2c_devices_proto_msgTypes[1]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Vec3) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Vec3) ProtoMessage() {}

func (x *Vec3) ProtoReflect() protoreflect.Message {
	mi := &file_i2c_devices_proto_msgTypes[1]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Vec3.ProtoReflect.Descriptor instead.
func (*Vec3) Descriptor() ([]byte, []int) {
	return file_i2c_devices_proto_rawDescGZIP(), []int{1}
}

func (x *Vec3) GetX() float64 {
	if x != nil {
		return x.X
	}
	return 0
}

func (x *Vec3) GetY() float64 {
	if x != nil {
		return x.Y
	}
	return 0
}

func (x *Vec3) GetZ() float64 {
	if x != nil {
		return x.Z
	}
	return 0
}

type Vec4 struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	W float64 `protobuf:"fixed64,1,opt,name=w,proto3" json:"w,omitempty"`
	X float64 `protobuf:"fixed64,2,opt,name=x,proto3" json:"x,omitempty"`
	Y float64 `protobuf:"fixed64,3,opt,name=y,proto3" json:"y,omitempty"`
	Z float64 `protobuf:"fixed64,4,opt,name=z,proto3" json:"z,omitempty"`
}

func (x *Vec4) Reset() {
	*x = Vec4{}
	if protoimpl.UnsafeEnabled {
		mi := &file_i2c_devices_proto_msgTypes[2]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Vec4) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Vec4) ProtoMessage() {}

func (x *Vec4) ProtoReflect() protoreflect.Message {
	mi := &file_i2c_devices_proto_msgTypes[2]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Vec4.ProtoReflect.Descriptor instead.
func (*Vec4) Descriptor() ([]byte, []int) {
	return file_i2c_devices_proto_rawDescGZIP(), []int{2}
}

func (x *Vec4) GetW() float64 {
	if x != nil {
		return x.W
	}
	return 0
}

func (x *Vec4) GetX() float64 {
	if x != nil {
		return x.X
	}
	return 0
}

func (x *Vec4) GetY() float64 {
	if x != nil {
		return x.Y
	}
	return 0
}

func (x *Vec4) GetZ() float64 {
	if x != nil {
		return x.Z
	}
	return 0
}

type AltimeterSnapshot struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	EventTimings *InputEventTimings `protobuf:"bytes,1,opt,name=event_timings,json=eventTimings,proto3" json:"event_timings,omitempty"`
	Altitude     float64            `protobuf:"fixed64,2,opt,name=altitude,proto3" json:"altitude,omitempty"`
}

func (x *AltimeterSnapshot) Reset() {
	*x = AltimeterSnapshot{}
	if protoimpl.UnsafeEnabled {
		mi := &file_i2c_devices_proto_msgTypes[3]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *AltimeterSnapshot) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*AltimeterSnapshot) ProtoMessage() {}

func (x *AltimeterSnapshot) ProtoReflect() protoreflect.Message {
	mi := &file_i2c_devices_proto_msgTypes[3]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use AltimeterSnapshot.ProtoReflect.Descriptor instead.
func (*AltimeterSnapshot) Descriptor() ([]byte, []int) {
	return file_i2c_devices_proto_rawDescGZIP(), []int{3}
}

func (x *AltimeterSnapshot) GetEventTimings() *InputEventTimings {
	if x != nil {
		return x.EventTimings
	}
	return nil
}

func (x *AltimeterSnapshot) GetAltitude() float64 {
	if x != nil {
		return x.Altitude
	}
	return 0
}

type IMUSnapshot struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	EventTimings          *InputEventTimings `protobuf:"bytes,1,opt,name=event_timings,json=eventTimings,proto3" json:"event_timings,omitempty"`
	OrientationQuaternion *Vec4              `protobuf:"bytes,2,opt,name=orientation_quaternion,json=orientationQuaternion,proto3" json:"orientation_quaternion,omitempty"`
	LinearAcceleration    *Vec3              `protobuf:"bytes,3,opt,name=linear_acceleration,json=linearAcceleration,proto3" json:"linear_acceleration,omitempty"`
	Euler                 *Vec3              `protobuf:"bytes,4,opt,name=euler,proto3" json:"euler,omitempty"`
}

func (x *IMUSnapshot) Reset() {
	*x = IMUSnapshot{}
	if protoimpl.UnsafeEnabled {
		mi := &file_i2c_devices_proto_msgTypes[4]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *IMUSnapshot) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*IMUSnapshot) ProtoMessage() {}

func (x *IMUSnapshot) ProtoReflect() protoreflect.Message {
	mi := &file_i2c_devices_proto_msgTypes[4]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use IMUSnapshot.ProtoReflect.Descriptor instead.
func (*IMUSnapshot) Descriptor() ([]byte, []int) {
	return file_i2c_devices_proto_rawDescGZIP(), []int{4}
}

func (x *IMUSnapshot) GetEventTimings() *InputEventTimings {
	if x != nil {
		return x.EventTimings
	}
	return nil
}

func (x *IMUSnapshot) GetOrientationQuaternion() *Vec4 {
	if x != nil {
		return x.OrientationQuaternion
	}
	return nil
}

func (x *IMUSnapshot) GetLinearAcceleration() *Vec3 {
	if x != nil {
		return x.LinearAcceleration
	}
	return nil
}

func (x *IMUSnapshot) GetEuler() *Vec3 {
	if x != nil {
		return x.Euler
	}
	return nil
}

var File_i2c_devices_proto protoreflect.FileDescriptor

var file_i2c_devices_proto_rawDesc = []byte{
	0x0a, 0x11, 0x69, 0x32, 0x63, 0x5f, 0x64, 0x65, 0x76, 0x69, 0x63, 0x65, 0x73, 0x2e, 0x70, 0x72,
	0x6f, 0x74, 0x6f, 0x12, 0x10, 0x67, 0x68, 0x6f, 0x73, 0x74, 0x70, 0x61, 0x63, 0x65, 0x72, 0x2e,
	0x69, 0x6e, 0x70, 0x75, 0x74, 0x1a, 0x0f, 0x74, 0x69, 0x6d, 0x65, 0x73, 0x74, 0x61, 0x6d, 0x70,
	0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x22, 0xd6, 0x01, 0x0a, 0x11, 0x49, 0x6e, 0x70, 0x75, 0x74,
	0x45, 0x76, 0x65, 0x6e, 0x74, 0x54, 0x69, 0x6d, 0x69, 0x6e, 0x67, 0x73, 0x12, 0x43, 0x0a, 0x0f,
	0x70, 0x65, 0x72, 0x69, 0x70, 0x68, 0x65, 0x72, 0x61, 0x6c, 0x5f, 0x74, 0x69, 0x6d, 0x65, 0x18,
	0x01, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x1a, 0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x70,
	0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2e, 0x54, 0x69, 0x6d, 0x65, 0x73, 0x74, 0x61, 0x6d,
	0x70, 0x52, 0x0e, 0x70, 0x65, 0x72, 0x69, 0x70, 0x68, 0x65, 0x72, 0x61, 0x6c, 0x54, 0x69, 0x6d,
	0x65, 0x12, 0x3b, 0x0a, 0x0b, 0x70, 0x61, 0x63, 0x6b, 0x65, 0x64, 0x5f, 0x74, 0x69, 0x6d, 0x65,
	0x18, 0x02, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x1a, 0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e,
	0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2e, 0x54, 0x69, 0x6d, 0x65, 0x73, 0x74, 0x61,
	0x6d, 0x70, 0x52, 0x0a, 0x70, 0x61, 0x63, 0x6b, 0x65, 0x64, 0x54, 0x69, 0x6d, 0x65, 0x12, 0x3f,
	0x0a, 0x0d, 0x75, 0x6e, 0x70, 0x61, 0x63, 0x6b, 0x65, 0x64, 0x5f, 0x74, 0x69, 0x6d, 0x65, 0x18,
	0x03, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x1a, 0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x70,
	0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2e, 0x54, 0x69, 0x6d, 0x65, 0x73, 0x74, 0x61, 0x6d,
	0x70, 0x52, 0x0c, 0x75, 0x6e, 0x70, 0x61, 0x63, 0x6b, 0x65, 0x64, 0x54, 0x69, 0x6d, 0x65, 0x22,
	0x30, 0x0a, 0x04, 0x56, 0x65, 0x63, 0x33, 0x12, 0x0c, 0x0a, 0x01, 0x78, 0x18, 0x01, 0x20, 0x01,
	0x28, 0x01, 0x52, 0x01, 0x78, 0x12, 0x0c, 0x0a, 0x01, 0x79, 0x18, 0x02, 0x20, 0x01, 0x28, 0x01,
	0x52, 0x01, 0x79, 0x12, 0x0c, 0x0a, 0x01, 0x7a, 0x18, 0x03, 0x20, 0x01, 0x28, 0x01, 0x52, 0x01,
	0x7a, 0x22, 0x3e, 0x0a, 0x04, 0x56, 0x65, 0x63, 0x34, 0x12, 0x0c, 0x0a, 0x01, 0x77, 0x18, 0x01,
	0x20, 0x01, 0x28, 0x01, 0x52, 0x01, 0x77, 0x12, 0x0c, 0x0a, 0x01, 0x78, 0x18, 0x02, 0x20, 0x01,
	0x28, 0x01, 0x52, 0x01, 0x78, 0x12, 0x0c, 0x0a, 0x01, 0x79, 0x18, 0x03, 0x20, 0x01, 0x28, 0x01,
	0x52, 0x01, 0x79, 0x12, 0x0c, 0x0a, 0x01, 0x7a, 0x18, 0x04, 0x20, 0x01, 0x28, 0x01, 0x52, 0x01,
	0x7a, 0x22, 0x79, 0x0a, 0x11, 0x41, 0x6c, 0x74, 0x69, 0x6d, 0x65, 0x74, 0x65, 0x72, 0x53, 0x6e,
	0x61, 0x70, 0x73, 0x68, 0x6f, 0x74, 0x12, 0x48, 0x0a, 0x0d, 0x65, 0x76, 0x65, 0x6e, 0x74, 0x5f,
	0x74, 0x69, 0x6d, 0x69, 0x6e, 0x67, 0x73, 0x18, 0x01, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x23, 0x2e,
	0x67, 0x68, 0x6f, 0x73, 0x74, 0x70, 0x61, 0x63, 0x65, 0x72, 0x2e, 0x69, 0x6e, 0x70, 0x75, 0x74,
	0x2e, 0x49, 0x6e, 0x70, 0x75, 0x74, 0x45, 0x76, 0x65, 0x6e, 0x74, 0x54, 0x69, 0x6d, 0x69, 0x6e,
	0x67, 0x73, 0x52, 0x0c, 0x65, 0x76, 0x65, 0x6e, 0x74, 0x54, 0x69, 0x6d, 0x69, 0x6e, 0x67, 0x73,
	0x12, 0x1a, 0x0a, 0x08, 0x61, 0x6c, 0x74, 0x69, 0x74, 0x75, 0x64, 0x65, 0x18, 0x02, 0x20, 0x01,
	0x28, 0x01, 0x52, 0x08, 0x61, 0x6c, 0x74, 0x69, 0x74, 0x75, 0x64, 0x65, 0x22, 0x9d, 0x02, 0x0a,
	0x0b, 0x49, 0x4d, 0x55, 0x53, 0x6e, 0x61, 0x70, 0x73, 0x68, 0x6f, 0x74, 0x12, 0x48, 0x0a, 0x0d,
	0x65, 0x76, 0x65, 0x6e, 0x74, 0x5f, 0x74, 0x69, 0x6d, 0x69, 0x6e, 0x67, 0x73, 0x18, 0x01, 0x20,
	0x01, 0x28, 0x0b, 0x32, 0x23, 0x2e, 0x67, 0x68, 0x6f, 0x73, 0x74, 0x70, 0x61, 0x63, 0x65, 0x72,
	0x2e, 0x69, 0x6e, 0x70, 0x75, 0x74, 0x2e, 0x49, 0x6e, 0x70, 0x75, 0x74, 0x45, 0x76, 0x65, 0x6e,
	0x74, 0x54, 0x69, 0x6d, 0x69, 0x6e, 0x67, 0x73, 0x52, 0x0c, 0x65, 0x76, 0x65, 0x6e, 0x74, 0x54,
	0x69, 0x6d, 0x69, 0x6e, 0x67, 0x73, 0x12, 0x4d, 0x0a, 0x16, 0x6f, 0x72, 0x69, 0x65, 0x6e, 0x74,
	0x61, 0x74, 0x69, 0x6f, 0x6e, 0x5f, 0x71, 0x75, 0x61, 0x74, 0x65, 0x72, 0x6e, 0x69, 0x6f, 0x6e,
	0x18, 0x02, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x16, 0x2e, 0x67, 0x68, 0x6f, 0x73, 0x74, 0x70, 0x61,
	0x63, 0x65, 0x72, 0x2e, 0x69, 0x6e, 0x70, 0x75, 0x74, 0x2e, 0x56, 0x65, 0x63, 0x34, 0x52, 0x15,
	0x6f, 0x72, 0x69, 0x65, 0x6e, 0x74, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x51, 0x75, 0x61, 0x74, 0x65,
	0x72, 0x6e, 0x69, 0x6f, 0x6e, 0x12, 0x47, 0x0a, 0x13, 0x6c, 0x69, 0x6e, 0x65, 0x61, 0x72, 0x5f,
	0x61, 0x63, 0x63, 0x65, 0x6c, 0x65, 0x72, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x18, 0x03, 0x20, 0x01,
	0x28, 0x0b, 0x32, 0x16, 0x2e, 0x67, 0x68, 0x6f, 0x73, 0x74, 0x70, 0x61, 0x63, 0x65, 0x72, 0x2e,
	0x69, 0x6e, 0x70, 0x75, 0x74, 0x2e, 0x56, 0x65, 0x63, 0x33, 0x52, 0x12, 0x6c, 0x69, 0x6e, 0x65,
	0x61, 0x72, 0x41, 0x63, 0x63, 0x65, 0x6c, 0x65, 0x72, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x12, 0x2c,
	0x0a, 0x05, 0x65, 0x75, 0x6c, 0x65, 0x72, 0x18, 0x04, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x16, 0x2e,
	0x67, 0x68, 0x6f, 0x73, 0x74, 0x70, 0x61, 0x63, 0x65, 0x72, 0x2e, 0x69, 0x6e, 0x70, 0x75, 0x74,
	0x2e, 0x56, 0x65, 0x63, 0x33, 0x52, 0x05, 0x65, 0x75, 0x6c, 0x65, 0x72, 0x62, 0x06, 0x70, 0x72,
	0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_i2c_devices_proto_rawDescOnce sync.Once
	file_i2c_devices_proto_rawDescData = file_i2c_devices_proto_rawDesc
)

func file_i2c_devices_proto_rawDescGZIP() []byte {
	file_i2c_devices_proto_rawDescOnce.Do(func() {
		file_i2c_devices_proto_rawDescData = protoimpl.X.CompressGZIP(file_i2c_devices_proto_rawDescData)
	})
	return file_i2c_devices_proto_rawDescData
}

var file_i2c_devices_proto_msgTypes = make([]protoimpl.MessageInfo, 5)
var file_i2c_devices_proto_goTypes = []interface{}{
	(*InputEventTimings)(nil),     // 0: ghostpacer.input.InputEventTimings
	(*Vec3)(nil),                  // 1: ghostpacer.input.Vec3
	(*Vec4)(nil),                  // 2: ghostpacer.input.Vec4
	(*AltimeterSnapshot)(nil),     // 3: ghostpacer.input.AltimeterSnapshot
	(*IMUSnapshot)(nil),           // 4: ghostpacer.input.IMUSnapshot
	(*timestamppb.Timestamp)(nil), // 5: google.protobuf.Timestamp
}
var file_i2c_devices_proto_depIdxs = []int32{
	5, // 0: ghostpacer.input.InputEventTimings.peripheral_time:type_name -> google.protobuf.Timestamp
	5, // 1: ghostpacer.input.InputEventTimings.packed_time:type_name -> google.protobuf.Timestamp
	5, // 2: ghostpacer.input.InputEventTimings.unpacked_time:type_name -> google.protobuf.Timestamp
	0, // 3: ghostpacer.input.AltimeterSnapshot.event_timings:type_name -> ghostpacer.input.InputEventTimings
	0, // 4: ghostpacer.input.IMUSnapshot.event_timings:type_name -> ghostpacer.input.InputEventTimings
	2, // 5: ghostpacer.input.IMUSnapshot.orientation_quaternion:type_name -> ghostpacer.input.Vec4
	1, // 6: ghostpacer.input.IMUSnapshot.linear_acceleration:type_name -> ghostpacer.input.Vec3
	1, // 7: ghostpacer.input.IMUSnapshot.euler:type_name -> ghostpacer.input.Vec3
	8, // [8:8] is the sub-list for method output_type
	8, // [8:8] is the sub-list for method input_type
	8, // [8:8] is the sub-list for extension type_name
	8, // [8:8] is the sub-list for extension extendee
	0, // [0:8] is the sub-list for field type_name
}

func init() { file_i2c_devices_proto_init() }
func file_i2c_devices_proto_init() {
	if File_i2c_devices_proto != nil {
		return
	}
	if !protoimpl.UnsafeEnabled {
		file_i2c_devices_proto_msgTypes[0].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*InputEventTimings); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_i2c_devices_proto_msgTypes[1].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Vec3); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_i2c_devices_proto_msgTypes[2].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Vec4); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_i2c_devices_proto_msgTypes[3].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*AltimeterSnapshot); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_i2c_devices_proto_msgTypes[4].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*IMUSnapshot); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_i2c_devices_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   5,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_i2c_devices_proto_goTypes,
		DependencyIndexes: file_i2c_devices_proto_depIdxs,
		MessageInfos:      file_i2c_devices_proto_msgTypes,
	}.Build()
	File_i2c_devices_proto = out.File
	file_i2c_devices_proto_rawDesc = nil
	file_i2c_devices_proto_goTypes = nil
	file_i2c_devices_proto_depIdxs = nil
}
