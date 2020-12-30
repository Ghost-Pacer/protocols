from libc.stdint cimport *
from libc.string cimport *
from cpython.ref cimport PyObject

from pyrobuf_list cimport *
from pyrobuf_util cimport *

import json

cdef class Vec3:


    cdef double _x
    cpdef _x__reset(self)
    cdef double _y
    cpdef _y__reset(self)
    cdef double _z
    cpdef _z__reset(self)


    cdef uint64_t __field_bitmap0

    cdef public bint _is_present_in_parent
    cdef bytes _cached_serialization

    cdef object _listener

    cpdef void reset(self)

    cpdef void Clear(self)
    cpdef void ClearField(self, field_name)
    cpdef void CopyFrom(self, Vec3 other_msg)
    cpdef bint HasField(self, field_name) except -1
    cpdef bint IsInitialized(self)
    cpdef void MergeFrom(self, Vec3 other_msg)
    cpdef int MergeFromString(self, data, size=*) except -1
    cpdef int ParseFromString(self, data, size=*, bint reset=*, bint cache=*) except -1
    cpdef bytes SerializeToString(self, bint cache=*)
    cpdef bytes SerializePartialToString(self)

    cdef void _clearfield(self, field_name)
    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache)

    cdef void _protobuf_serialize(self, bytearray buf, bint cache)

    cpdef void _Modified(self)

cdef class Mat3:


    cdef Vec3 _row1
    cpdef _row1__reset(self)
    cdef Vec3 _row2
    cpdef _row2__reset(self)
    cdef Vec3 _row3
    cpdef _row3__reset(self)


    cdef uint64_t __field_bitmap0

    cdef public bint _is_present_in_parent
    cdef bytes _cached_serialization

    cdef object _listener

    cpdef void reset(self)

    cpdef void Clear(self)
    cpdef void ClearField(self, field_name)
    cpdef void CopyFrom(self, Mat3 other_msg)
    cpdef bint HasField(self, field_name) except -1
    cpdef bint IsInitialized(self)
    cpdef void MergeFrom(self, Mat3 other_msg)
    cpdef int MergeFromString(self, data, size=*) except -1
    cpdef int ParseFromString(self, data, size=*, bint reset=*, bint cache=*) except -1
    cpdef bytes SerializeToString(self, bint cache=*)
    cpdef bytes SerializePartialToString(self)

    cdef void _clearfield(self, field_name)
    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache)

    cdef void _protobuf_serialize(self, bytearray buf, bint cache)

    cpdef void _Modified(self)

cdef class Avatar:


    cdef Vec3 _avatarPosition
    cpdef _avatarPosition__reset(self)
    cdef Vec3 _avatarRotation
    cpdef _avatarRotation__reset(self)
    cdef double _animationPhase
    cpdef _animationPhase__reset(self)
    cdef Vec3 _cameraPosition
    cpdef _cameraPosition__reset(self)
    cdef Mat3 _cameraRotation
    cpdef _cameraRotation__reset(self)


    cdef uint64_t __field_bitmap0

    cdef public bint _is_present_in_parent
    cdef bytes _cached_serialization

    cdef object _listener

    cpdef void reset(self)

    cpdef void Clear(self)
    cpdef void ClearField(self, field_name)
    cpdef void CopyFrom(self, Avatar other_msg)
    cpdef bint HasField(self, field_name) except -1
    cpdef bint IsInitialized(self)
    cpdef void MergeFrom(self, Avatar other_msg)
    cpdef int MergeFromString(self, data, size=*) except -1
    cpdef int ParseFromString(self, data, size=*, bint reset=*, bint cache=*) except -1
    cpdef bytes SerializeToString(self, bint cache=*)
    cpdef bytes SerializePartialToString(self)

    cdef void _clearfield(self, field_name)
    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache)

    cdef void _protobuf_serialize(self, bytearray buf, bint cache)

    cpdef void _Modified(self)

cdef class Menu:


    cdef StringList _entries
    cpdef _entries__reset(self)
    cdef uint32_t _activeEntryIndex
    cpdef _activeEntryIndex__reset(self)


    cdef uint64_t __field_bitmap0

    cdef public bint _is_present_in_parent
    cdef bytes _cached_serialization

    cdef object _listener

    cpdef void reset(self)

    cpdef void Clear(self)
    cpdef void ClearField(self, field_name)
    cpdef void CopyFrom(self, Menu other_msg)
    cpdef bint HasField(self, field_name) except -1
    cpdef bint IsInitialized(self)
    cpdef void MergeFrom(self, Menu other_msg)
    cpdef int MergeFromString(self, data, size=*) except -1
    cpdef int ParseFromString(self, data, size=*, bint reset=*, bint cache=*) except -1
    cpdef bytes SerializeToString(self, bint cache=*)
    cpdef bytes SerializePartialToString(self)

    cdef void _clearfield(self, field_name)
    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache)

    cdef void _protobuf_serialize(self, bytearray buf, bint cache)

    cpdef void _Modified(self)

cdef class Banner:


    cdef StringList _lines
    cpdef _lines__reset(self)
    cdef _BannerPosition _position
    cpdef _position__reset(self)


    cdef uint64_t __field_bitmap0

    cdef public bint _is_present_in_parent
    cdef bytes _cached_serialization

    cdef object _listener

    cpdef void reset(self)

    cpdef void Clear(self)
    cpdef void ClearField(self, field_name)
    cpdef void CopyFrom(self, Banner other_msg)
    cpdef bint HasField(self, field_name) except -1
    cpdef bint IsInitialized(self)
    cpdef void MergeFrom(self, Banner other_msg)
    cpdef int MergeFromString(self, data, size=*) except -1
    cpdef int ParseFromString(self, data, size=*, bint reset=*, bint cache=*) except -1
    cpdef bytes SerializeToString(self, bint cache=*)
    cpdef bytes SerializePartialToString(self)

    cdef void _clearfield(self, field_name)
    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache)

    cdef void _protobuf_serialize(self, bytearray buf, bint cache)

    cpdef void _Modified(self)

cdef enum _BannerPosition:
    _BannerPosition_TOP = 0
    _BannerPosition_CENTER = 1

cdef class Legend:


    cdef bint _upActive
    cpdef _upActive__reset(self)
    cdef bint _selectActive
    cpdef _selectActive__reset(self)
    cdef bint _downActive
    cpdef _downActive__reset(self)


    cdef uint64_t __field_bitmap0

    cdef public bint _is_present_in_parent
    cdef bytes _cached_serialization

    cdef object _listener

    cpdef void reset(self)

    cpdef void Clear(self)
    cpdef void ClearField(self, field_name)
    cpdef void CopyFrom(self, Legend other_msg)
    cpdef bint HasField(self, field_name) except -1
    cpdef bint IsInitialized(self)
    cpdef void MergeFrom(self, Legend other_msg)
    cpdef int MergeFromString(self, data, size=*) except -1
    cpdef int ParseFromString(self, data, size=*, bint reset=*, bint cache=*) except -1
    cpdef bytes SerializeToString(self, bint cache=*)
    cpdef bytes SerializePartialToString(self)

    cdef void _clearfield(self, field_name)
    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache)

    cdef void _protobuf_serialize(self, bytearray buf, bint cache)

    cpdef void _Modified(self)

cdef class Frame:


    cdef Avatar _avatar
    cpdef _avatar__reset(self)
    cdef Legend _legend
    cpdef _legend__reset(self)
    cdef Menu _menu
    cpdef _menu__reset(self)
    cdef Banner _banner
    cpdef _banner__reset(self)


    cdef uint64_t __field_bitmap0

    cdef public bint _is_present_in_parent
    cdef bytes _cached_serialization

    cdef object _listener

    cpdef void reset(self)

    cpdef void Clear(self)
    cpdef void ClearField(self, field_name)
    cpdef void CopyFrom(self, Frame other_msg)
    cpdef bint HasField(self, field_name) except -1
    cpdef bint IsInitialized(self)
    cpdef void MergeFrom(self, Frame other_msg)
    cpdef int MergeFromString(self, data, size=*) except -1
    cpdef int ParseFromString(self, data, size=*, bint reset=*, bint cache=*) except -1
    cpdef bytes SerializeToString(self, bint cache=*)
    cpdef bytes SerializePartialToString(self)

    cdef void _clearfield(self, field_name)
    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache)

    cdef void _protobuf_serialize(self, bytearray buf, bint cache)

    cpdef void _Modified(self)