from libc.stdint cimport *
from libc.string cimport *

from pyrobuf_list cimport *
from pyrobuf_util cimport *

import base64
import json
import warnings

class DecodeError(Exception):
    pass

cdef class Vec3:

    def __cinit__(self):
        self._listener = noop_listener

    

    def __init__(self, **kwargs):
        self.reset()
        if kwargs:
            for field_name, field_value in kwargs.items():
                try:
                    setattr(self, field_name, field_value)
                except AttributeError:
                    raise ValueError('Protocol message has no "%s" field.' % (field_name,))
        return

    def __str__(self):
        fields = [
                          'x',
                          'y',
                          'z',]
        components = ['{0}: {1}'.format(field, getattr(self, field)) for field in fields]
        messages = []
        for message in messages:
            components.append('{0}: {{'.format(message))
            for line in str(getattr(self, message)).split('\n'):
                components.append('  {0}'.format(line))
            components.append('}')
        return '\n'.join(components)

    
    cpdef _x__reset(self):
        self._x = 0
        self.__field_bitmap0 &= ~1
    cpdef _y__reset(self):
        self._y = 0
        self.__field_bitmap0 &= ~2
    cpdef _z__reset(self):
        self._z = 0
        self.__field_bitmap0 &= ~4

    cpdef void reset(self):
        # reset values and populate defaults
    
        self._x__reset()
        self._y__reset()
        self._z__reset()
        return

    
    @property
    def x(self):
        return self._x

    @x.setter
    def x(self, value):
        self.__field_bitmap0 |= 1
        self._x = value
        self._Modified()
    
    @property
    def y(self):
        return self._y

    @y.setter
    def y(self, value):
        self.__field_bitmap0 |= 2
        self._y = value
        self._Modified()
    
    @property
    def z(self):
        return self._z

    @z.setter
    def z(self, value):
        self.__field_bitmap0 |= 4
        self._z = value
        self._Modified()
    

    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache):
        cdef int current_offset = 0
        cdef int64_t key
        while current_offset < size:
            key = get_varint64(memory, &current_offset)
            # x
            if key == 9:
                self.__field_bitmap0 |= 1
                self._x = (<double *>&memory[current_offset])[0]
                current_offset += sizeof(double)
            # y
            elif key == 17:
                self.__field_bitmap0 |= 2
                self._y = (<double *>&memory[current_offset])[0]
                current_offset += sizeof(double)
            # z
            elif key == 25:
                self.__field_bitmap0 |= 4
                self._z = (<double *>&memory[current_offset])[0]
                current_offset += sizeof(double)
            # Unknown field - need to skip proper number of bytes
            else:
                assert skip_generic(memory, &current_offset, size, key & 0x7)

        self._is_present_in_parent = True

        return current_offset

    cpdef void Clear(self):
        """Clears all data that was set in the message."""
        self.reset()
        self._Modified()

    cpdef void ClearField(self, field_name):
        """Clears the contents of a given field."""
        self._clearfield(field_name)
        self._Modified()

    cdef void _clearfield(self, field_name):
        if field_name == 'x':
            self._x__reset()
        elif field_name == 'y':
            self._y__reset()
        elif field_name == 'z':
            self._z__reset()
        else:
            raise ValueError('Protocol message has no "%s" field.' % field_name)

    cpdef void CopyFrom(self, Vec3 other_msg):
        """
        Copies the content of the specified message into the current message.

        Params:
            other_msg (Vec3): Message to copy into the current one.
        """
        if self is other_msg:
            return
        self.reset()
        self.MergeFrom(other_msg)

    cpdef bint HasField(self, field_name) except -1:
        """
        Checks if a certain field is set for the message.

        Params:
            field_name (str): The name of the field to check.
        """
        if field_name == 'x':
            return self.__field_bitmap0 & 1 == 1
        if field_name == 'y':
            return self.__field_bitmap0 & 2 == 2
        if field_name == 'z':
            return self.__field_bitmap0 & 4 == 4
        raise ValueError('Protocol message has no singular "%s" field.' % field_name)

    cpdef bint IsInitialized(self):
        """
        Checks if the message is initialized.

        Returns:
            bool: True if the message is initialized (i.e. all of its required
                fields are set).
        """

    

        return True

    cpdef void MergeFrom(self, Vec3 other_msg):
        """
        Merges the contents of the specified message into the current message.

        Params:
            other_msg: Message to merge into the current message.
        """

        if self is other_msg:
            return

    
        if other_msg.__field_bitmap0 & 1 == 1:
            self._x = other_msg._x
            self.__field_bitmap0 |= 1
        if other_msg.__field_bitmap0 & 2 == 2:
            self._y = other_msg._y
            self.__field_bitmap0 |= 2
        if other_msg.__field_bitmap0 & 4 == 4:
            self._z = other_msg._z
            self.__field_bitmap0 |= 4

        self._Modified()

    cpdef int MergeFromString(self, data, size=None) except -1:
        """
        Merges serialized protocol buffer data into this message.

        Params:
            data (bytes): a string of binary data.
            size (int): optional - the length of the data string

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        buf = self._protobuf_deserialize(data, length, False)

        if buf != length:
            raise DecodeError("Truncated message: got %s expected %s" % (buf, size))

        self._Modified()

        return buf

    cpdef int ParseFromString(self, data, size=None, bint reset=True, bint cache=False) except -1:
        """
        Populate the message class from a string of protobuf encoded binary data.

        Params:
            data (bytes): a string of binary data
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
            cache (bool): optional - whether to cache serialized data

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        if reset:
            self.reset()

        buf = self._protobuf_deserialize(data, length, cache)

        if buf != length:
            raise DecodeError("Truncated message")

        self._Modified()

        if cache:
            self._cached_serialization = data

        return buf

    @classmethod
    def FromString(cls, s):
        message = cls()
        message.MergeFromString(s)
        return message

    cdef void _protobuf_serialize(self, bytearray buf, bint cache):
        # x
        if self.__field_bitmap0 & 1 == 1:
            set_varint64(9, buf)
            buf += (<unsigned char *>&self._x)[:sizeof(double)]
        # y
        if self.__field_bitmap0 & 2 == 2:
            set_varint64(17, buf)
            buf += (<unsigned char *>&self._y)[:sizeof(double)]
        # z
        if self.__field_bitmap0 & 4 == 4:
            set_varint64(25, buf)
            buf += (<unsigned char *>&self._z)[:sizeof(double)]

    cpdef void _Modified(self):
        self._is_present_in_parent = True
        self._listener()
        self._cached_serialization = None

    

    cpdef bytes SerializeToString(self, bint cache=False):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """

    

        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, cache)
        cdef bytes out = bytes(buf)

        if cache:
            self._cached_serialization = out

        return out

    cpdef bytes SerializePartialToString(self):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """
        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, False)
        return bytes(buf)

    def SetInParent(self):
        """
        Mark this an present in the parent.
        """
        self._Modified()

    def ParseFromJson(self, data, size=None, reset=True):
        """
        Populate the message class from a json string.

        Params:
            data (str): a json string
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
        """
        if size is None:
            size = len(data)
        d = json.loads(data[:size])
        self.ParseFromDict(d, reset)

    def SerializeToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializeToDict()
        return json.dumps(d, **kwargs)

    def SerializePartialToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializePartialToDict()
        return json.dumps(d, **kwargs)

    def ParseFromDict(self, d, reset=True):
        """
        Populate the message class from a Python dictionary.

        Params:
            d (dict): a Python dictionary representing the message
            reset (bool): optional - whether to reset to default values before serializing
        """
        if reset:
            self.reset()

        assert type(d) == dict
        try:
            self.x = d["x"]
        except KeyError:
            pass
        try:
            self.y = d["y"]
        except KeyError:
            pass
        try:
            self.z = d["z"]
        except KeyError:
            pass

        self._Modified()

        return

    def SerializeToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        if self.__field_bitmap0 & 1 == 1:
            out["x"] = self.x
        if self.__field_bitmap0 & 2 == 2:
            out["y"] = self.y
        if self.__field_bitmap0 & 4 == 4:
            out["z"] = self.z

        return out

    def SerializePartialToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        if self.__field_bitmap0 & 1 == 1:
            out["x"] = self.x
        if self.__field_bitmap0 & 2 == 2:
            out["y"] = self.y
        if self.__field_bitmap0 & 4 == 4:
            out["z"] = self.z

        return out

    def Items(self):
        """
        Iterator over the field names and values of the message.

        Returns:
            iterator
        """
        yield 'x', self.x
        yield 'y', self.y
        yield 'z', self.z

    def Fields(self):
        """
        Iterator over the field names of the message.

        Returns:
            iterator
        """
        yield 'x'
        yield 'y'
        yield 'z'

    def Values(self):
        """
        Iterator over the values of the message.

        Returns:
            iterator
        """
        yield self.x
        yield self.y
        yield self.z

    

    def Setters(self):
        """
        Iterator over functions to set the fields in a message.

        Returns:
            iterator
        """
        def setter(value):
            self.x = value
        yield setter
        def setter(value):
            self.y = value
        yield setter
        def setter(value):
            self.z = value
        yield setter

    


cdef class Mat3:

    def __cinit__(self):
        self._listener = noop_listener

    def __dealloc__(self):
        # Remove any references to self from child messages or repeated fields
        if self._row1 is not None:
            self._row1._listener = noop_listener
        if self._row2 is not None:
            self._row2._listener = noop_listener
        if self._row3 is not None:
            self._row3._listener = noop_listener

    def __init__(self, **kwargs):
        self.reset()
        if kwargs:
            for field_name, field_value in kwargs.items():
                try:
                    if field_name in ('row1','row2','row3',):
                        getattr(self, field_name).MergeFrom(field_value)
                    else:
                        setattr(self, field_name, field_value)
                except AttributeError:
                    raise ValueError('Protocol message has no "%s" field.' % (field_name,))
        return

    def __str__(self):
        fields = []
        components = ['{0}: {1}'.format(field, getattr(self, field)) for field in fields]
        messages = [
                            'row1',
                            'row2',
                            'row3',]
        for message in messages:
            components.append('{0}: {{'.format(message))
            for line in str(getattr(self, message)).split('\n'):
                components.append('  {0}'.format(line))
            components.append('}')
        return '\n'.join(components)

    
    cpdef _row1__reset(self):
        if self._row1 is not None:
            self._row1._listener = noop_listener
        self._row1 = None
    cpdef _row2__reset(self):
        if self._row2 is not None:
            self._row2._listener = noop_listener
        self._row2 = None
    cpdef _row3__reset(self):
        if self._row3 is not None:
            self._row3._listener = noop_listener
        self._row3 = None

    cpdef void reset(self):
        # reset values and populate defaults
    
        self._row1__reset()
        self._row2__reset()
        self._row3__reset()
        return

    
    @property
    def row1(self):
        # lazy init sub messages
        if self._row1 is None:
            self._row1 = Vec3.__new__(Vec3)
            self._row1.reset()
            self._row1._listener = self._Modified
            self._listener()
        return self._row1

    @row1.setter
    def row1(self, value):
        if self._row1 is not None:
            self._row1._listener = noop_listener
        self._row1 = value
        self._row1._listener = self._Modified
        self._Modified()
    
    @property
    def row2(self):
        # lazy init sub messages
        if self._row2 is None:
            self._row2 = Vec3.__new__(Vec3)
            self._row2.reset()
            self._row2._listener = self._Modified
            self._listener()
        return self._row2

    @row2.setter
    def row2(self, value):
        if self._row2 is not None:
            self._row2._listener = noop_listener
        self._row2 = value
        self._row2._listener = self._Modified
        self._Modified()
    
    @property
    def row3(self):
        # lazy init sub messages
        if self._row3 is None:
            self._row3 = Vec3.__new__(Vec3)
            self._row3.reset()
            self._row3._listener = self._Modified
            self._listener()
        return self._row3

    @row3.setter
    def row3(self, value):
        if self._row3 is not None:
            self._row3._listener = noop_listener
        self._row3 = value
        self._row3._listener = self._Modified
        self._Modified()
    

    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache):
        cdef int current_offset = 0
        cdef int64_t key
        cdef int64_t field_size
        while current_offset < size:
            key = get_varint64(memory, &current_offset)
            # row1
            if key == 10:
                field_size = get_varint64(memory, &current_offset)
                if self._row1 is None:
                    self._row1 = Vec3.__new__(Vec3)
                    self._row1._listener = self._Modified
                self._row1.reset()
                if cache:
                    self._row1._cached_serialization = bytes(memory[current_offset:current_offset+field_size])
                current_offset += self._row1._protobuf_deserialize(memory+current_offset, <int>field_size, cache)
            # row2
            elif key == 18:
                field_size = get_varint64(memory, &current_offset)
                if self._row2 is None:
                    self._row2 = Vec3.__new__(Vec3)
                    self._row2._listener = self._Modified
                self._row2.reset()
                if cache:
                    self._row2._cached_serialization = bytes(memory[current_offset:current_offset+field_size])
                current_offset += self._row2._protobuf_deserialize(memory+current_offset, <int>field_size, cache)
            # row3
            elif key == 26:
                field_size = get_varint64(memory, &current_offset)
                if self._row3 is None:
                    self._row3 = Vec3.__new__(Vec3)
                    self._row3._listener = self._Modified
                self._row3.reset()
                if cache:
                    self._row3._cached_serialization = bytes(memory[current_offset:current_offset+field_size])
                current_offset += self._row3._protobuf_deserialize(memory+current_offset, <int>field_size, cache)
            # Unknown field - need to skip proper number of bytes
            else:
                assert skip_generic(memory, &current_offset, size, key & 0x7)

        self._is_present_in_parent = True

        return current_offset

    cpdef void Clear(self):
        """Clears all data that was set in the message."""
        self.reset()
        self._Modified()

    cpdef void ClearField(self, field_name):
        """Clears the contents of a given field."""
        self._clearfield(field_name)
        self._Modified()

    cdef void _clearfield(self, field_name):
        if field_name == 'row1':
            self._row1__reset()
        elif field_name == 'row2':
            self._row2__reset()
        elif field_name == 'row3':
            self._row3__reset()
        else:
            raise ValueError('Protocol message has no "%s" field.' % field_name)

    cpdef void CopyFrom(self, Mat3 other_msg):
        """
        Copies the content of the specified message into the current message.

        Params:
            other_msg (Mat3): Message to copy into the current one.
        """
        if self is other_msg:
            return
        self.reset()
        self.MergeFrom(other_msg)

    cpdef bint HasField(self, field_name) except -1:
        """
        Checks if a certain field is set for the message.

        Params:
            field_name (str): The name of the field to check.
        """
        if field_name == 'row1':
            return self._row1 is not None and self._row1._is_present_in_parent
        if field_name == 'row2':
            return self._row2 is not None and self._row2._is_present_in_parent
        if field_name == 'row3':
            return self._row3 is not None and self._row3._is_present_in_parent
        raise ValueError('Protocol message has no singular "%s" field.' % field_name)

    cpdef bint IsInitialized(self):
        """
        Checks if the message is initialized.

        Returns:
            bool: True if the message is initialized (i.e. all of its required
                fields are set).
        """

    

        return True

    cpdef void MergeFrom(self, Mat3 other_msg):
        """
        Merges the contents of the specified message into the current message.

        Params:
            other_msg: Message to merge into the current message.
        """

        if self is other_msg:
            return

    
        if other_msg._row1 is not None and other_msg._row1._is_present_in_parent:
            if self._row1 is None:
                self._row1 = Vec3.__new__(Vec3)
                self._row1.reset()
                self._row1._listener = self._Modified
            self._row1.MergeFrom(other_msg._row1)
        if other_msg._row2 is not None and other_msg._row2._is_present_in_parent:
            if self._row2 is None:
                self._row2 = Vec3.__new__(Vec3)
                self._row2.reset()
                self._row2._listener = self._Modified
            self._row2.MergeFrom(other_msg._row2)
        if other_msg._row3 is not None and other_msg._row3._is_present_in_parent:
            if self._row3 is None:
                self._row3 = Vec3.__new__(Vec3)
                self._row3.reset()
                self._row3._listener = self._Modified
            self._row3.MergeFrom(other_msg._row3)

        self._Modified()

    cpdef int MergeFromString(self, data, size=None) except -1:
        """
        Merges serialized protocol buffer data into this message.

        Params:
            data (bytes): a string of binary data.
            size (int): optional - the length of the data string

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        buf = self._protobuf_deserialize(data, length, False)

        if buf != length:
            raise DecodeError("Truncated message: got %s expected %s" % (buf, size))

        self._Modified()

        return buf

    cpdef int ParseFromString(self, data, size=None, bint reset=True, bint cache=False) except -1:
        """
        Populate the message class from a string of protobuf encoded binary data.

        Params:
            data (bytes): a string of binary data
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
            cache (bool): optional - whether to cache serialized data

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        if reset:
            self.reset()

        buf = self._protobuf_deserialize(data, length, cache)

        if buf != length:
            raise DecodeError("Truncated message")

        self._Modified()

        if cache:
            self._cached_serialization = data

        return buf

    @classmethod
    def FromString(cls, s):
        message = cls()
        message.MergeFromString(s)
        return message

    cdef void _protobuf_serialize(self, bytearray buf, bint cache):
        # row1
        cdef bytearray row1_buf
        if self._row1 is not None and self._row1._is_present_in_parent:
            set_varint64(10, buf)
            if self._row1._cached_serialization is not None:
                set_varint64(len(self._row1._cached_serialization), buf)
                buf += self._row1._cached_serialization
            else:
                row1_buf = bytearray()
                self._row1._protobuf_serialize(row1_buf, cache)
                set_varint64(len(row1_buf), buf)
                buf += row1_buf
                if cache:
                    self._row1._cached_serialization = bytes(row1_buf)
        # row2
        cdef bytearray row2_buf
        if self._row2 is not None and self._row2._is_present_in_parent:
            set_varint64(18, buf)
            if self._row2._cached_serialization is not None:
                set_varint64(len(self._row2._cached_serialization), buf)
                buf += self._row2._cached_serialization
            else:
                row2_buf = bytearray()
                self._row2._protobuf_serialize(row2_buf, cache)
                set_varint64(len(row2_buf), buf)
                buf += row2_buf
                if cache:
                    self._row2._cached_serialization = bytes(row2_buf)
        # row3
        cdef bytearray row3_buf
        if self._row3 is not None and self._row3._is_present_in_parent:
            set_varint64(26, buf)
            if self._row3._cached_serialization is not None:
                set_varint64(len(self._row3._cached_serialization), buf)
                buf += self._row3._cached_serialization
            else:
                row3_buf = bytearray()
                self._row3._protobuf_serialize(row3_buf, cache)
                set_varint64(len(row3_buf), buf)
                buf += row3_buf
                if cache:
                    self._row3._cached_serialization = bytes(row3_buf)

    cpdef void _Modified(self):
        self._is_present_in_parent = True
        self._listener()
        self._cached_serialization = None

    

    cpdef bytes SerializeToString(self, bint cache=False):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """

    

        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, cache)
        cdef bytes out = bytes(buf)

        if cache:
            self._cached_serialization = out

        return out

    cpdef bytes SerializePartialToString(self):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """
        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, False)
        return bytes(buf)

    def SetInParent(self):
        """
        Mark this an present in the parent.
        """
        self._Modified()

    def ParseFromJson(self, data, size=None, reset=True):
        """
        Populate the message class from a json string.

        Params:
            data (str): a json string
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
        """
        if size is None:
            size = len(data)
        d = json.loads(data[:size])
        self.ParseFromDict(d, reset)

    def SerializeToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializeToDict()
        return json.dumps(d, **kwargs)

    def SerializePartialToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializePartialToDict()
        return json.dumps(d, **kwargs)

    def ParseFromDict(self, d, reset=True):
        """
        Populate the message class from a Python dictionary.

        Params:
            d (dict): a Python dictionary representing the message
            reset (bool): optional - whether to reset to default values before serializing
        """
        if reset:
            self.reset()

        assert type(d) == dict
        try:
            self.row1.ParseFromDict(d["row1"])
        except KeyError:
            pass
        try:
            self.row2.ParseFromDict(d["row2"])
        except KeyError:
            pass
        try:
            self.row3.ParseFromDict(d["row3"])
        except KeyError:
            pass

        self._Modified()

        return

    def SerializeToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        row1_dict = self.row1.SerializeToDict()
        if row1_dict != {}:
            out["row1"] = row1_dict
        row2_dict = self.row2.SerializeToDict()
        if row2_dict != {}:
            out["row2"] = row2_dict
        row3_dict = self.row3.SerializeToDict()
        if row3_dict != {}:
            out["row3"] = row3_dict

        return out

    def SerializePartialToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        row1_dict = self.row1.SerializePartialToDict()
        if row1_dict != {}:
            out["row1"] = row1_dict
        row2_dict = self.row2.SerializePartialToDict()
        if row2_dict != {}:
            out["row2"] = row2_dict
        row3_dict = self.row3.SerializePartialToDict()
        if row3_dict != {}:
            out["row3"] = row3_dict

        return out

    def Items(self):
        """
        Iterator over the field names and values of the message.

        Returns:
            iterator
        """
        yield 'row1', self.row1
        yield 'row2', self.row2
        yield 'row3', self.row3

    def Fields(self):
        """
        Iterator over the field names of the message.

        Returns:
            iterator
        """
        yield 'row1'
        yield 'row2'
        yield 'row3'

    def Values(self):
        """
        Iterator over the values of the message.

        Returns:
            iterator
        """
        yield self.row1
        yield self.row2
        yield self.row3

    

    def Setters(self):
        """
        Iterator over functions to set the fields in a message.

        Returns:
            iterator
        """
        def setter(value):
            self.row1 = value
        yield setter
        def setter(value):
            self.row2 = value
        yield setter
        def setter(value):
            self.row3 = value
        yield setter

    


cdef class Avatar:

    def __cinit__(self):
        self._listener = noop_listener

    def __dealloc__(self):
        # Remove any references to self from child messages or repeated fields
        if self._avatarPosition is not None:
            self._avatarPosition._listener = noop_listener
        if self._avatarRotation is not None:
            self._avatarRotation._listener = noop_listener
        if self._cameraPosition is not None:
            self._cameraPosition._listener = noop_listener
        if self._cameraRotation is not None:
            self._cameraRotation._listener = noop_listener

    def __init__(self, **kwargs):
        self.reset()
        if kwargs:
            for field_name, field_value in kwargs.items():
                try:
                    if field_name in ('avatarPosition','avatarRotation','cameraPosition','cameraRotation',):
                        getattr(self, field_name).MergeFrom(field_value)
                    else:
                        setattr(self, field_name, field_value)
                except AttributeError:
                    raise ValueError('Protocol message has no "%s" field.' % (field_name,))
        return

    def __str__(self):
        fields = [
                          'animationPhase',]
        components = ['{0}: {1}'.format(field, getattr(self, field)) for field in fields]
        messages = [
                            'avatarPosition',
                            'avatarRotation',
                            'cameraPosition',
                            'cameraRotation',]
        for message in messages:
            components.append('{0}: {{'.format(message))
            for line in str(getattr(self, message)).split('\n'):
                components.append('  {0}'.format(line))
            components.append('}')
        return '\n'.join(components)

    
    cpdef _avatarPosition__reset(self):
        if self._avatarPosition is not None:
            self._avatarPosition._listener = noop_listener
        self._avatarPosition = None
    cpdef _avatarRotation__reset(self):
        if self._avatarRotation is not None:
            self._avatarRotation._listener = noop_listener
        self._avatarRotation = None
    cpdef _animationPhase__reset(self):
        self._animationPhase = 0
        self.__field_bitmap0 &= ~4
    cpdef _cameraPosition__reset(self):
        if self._cameraPosition is not None:
            self._cameraPosition._listener = noop_listener
        self._cameraPosition = None
    cpdef _cameraRotation__reset(self):
        if self._cameraRotation is not None:
            self._cameraRotation._listener = noop_listener
        self._cameraRotation = None

    cpdef void reset(self):
        # reset values and populate defaults
    
        self._avatarPosition__reset()
        self._avatarRotation__reset()
        self._animationPhase__reset()
        self._cameraPosition__reset()
        self._cameraRotation__reset()
        return

    
    @property
    def avatarPosition(self):
        # lazy init sub messages
        if self._avatarPosition is None:
            self._avatarPosition = Vec3.__new__(Vec3)
            self._avatarPosition.reset()
            self._avatarPosition._listener = self._Modified
            self._listener()
        return self._avatarPosition

    @avatarPosition.setter
    def avatarPosition(self, value):
        if self._avatarPosition is not None:
            self._avatarPosition._listener = noop_listener
        self._avatarPosition = value
        self._avatarPosition._listener = self._Modified
        self._Modified()
    
    @property
    def avatarRotation(self):
        # lazy init sub messages
        if self._avatarRotation is None:
            self._avatarRotation = Vec3.__new__(Vec3)
            self._avatarRotation.reset()
            self._avatarRotation._listener = self._Modified
            self._listener()
        return self._avatarRotation

    @avatarRotation.setter
    def avatarRotation(self, value):
        if self._avatarRotation is not None:
            self._avatarRotation._listener = noop_listener
        self._avatarRotation = value
        self._avatarRotation._listener = self._Modified
        self._Modified()
    
    @property
    def animationPhase(self):
        return self._animationPhase

    @animationPhase.setter
    def animationPhase(self, value):
        self.__field_bitmap0 |= 4
        self._animationPhase = value
        self._Modified()
    
    @property
    def cameraPosition(self):
        # lazy init sub messages
        if self._cameraPosition is None:
            self._cameraPosition = Vec3.__new__(Vec3)
            self._cameraPosition.reset()
            self._cameraPosition._listener = self._Modified
            self._listener()
        return self._cameraPosition

    @cameraPosition.setter
    def cameraPosition(self, value):
        if self._cameraPosition is not None:
            self._cameraPosition._listener = noop_listener
        self._cameraPosition = value
        self._cameraPosition._listener = self._Modified
        self._Modified()
    
    @property
    def cameraRotation(self):
        # lazy init sub messages
        if self._cameraRotation is None:
            self._cameraRotation = Mat3.__new__(Mat3)
            self._cameraRotation.reset()
            self._cameraRotation._listener = self._Modified
            self._listener()
        return self._cameraRotation

    @cameraRotation.setter
    def cameraRotation(self, value):
        if self._cameraRotation is not None:
            self._cameraRotation._listener = noop_listener
        self._cameraRotation = value
        self._cameraRotation._listener = self._Modified
        self._Modified()
    

    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache):
        cdef int current_offset = 0
        cdef int64_t key
        cdef int64_t field_size
        while current_offset < size:
            key = get_varint64(memory, &current_offset)
            # avatarPosition
            if key == 10:
                field_size = get_varint64(memory, &current_offset)
                if self._avatarPosition is None:
                    self._avatarPosition = Vec3.__new__(Vec3)
                    self._avatarPosition._listener = self._Modified
                self._avatarPosition.reset()
                if cache:
                    self._avatarPosition._cached_serialization = bytes(memory[current_offset:current_offset+field_size])
                current_offset += self._avatarPosition._protobuf_deserialize(memory+current_offset, <int>field_size, cache)
            # avatarRotation
            elif key == 18:
                field_size = get_varint64(memory, &current_offset)
                if self._avatarRotation is None:
                    self._avatarRotation = Vec3.__new__(Vec3)
                    self._avatarRotation._listener = self._Modified
                self._avatarRotation.reset()
                if cache:
                    self._avatarRotation._cached_serialization = bytes(memory[current_offset:current_offset+field_size])
                current_offset += self._avatarRotation._protobuf_deserialize(memory+current_offset, <int>field_size, cache)
            # animationPhase
            elif key == 25:
                self.__field_bitmap0 |= 4
                self._animationPhase = (<double *>&memory[current_offset])[0]
                current_offset += sizeof(double)
            # cameraPosition
            elif key == 34:
                field_size = get_varint64(memory, &current_offset)
                if self._cameraPosition is None:
                    self._cameraPosition = Vec3.__new__(Vec3)
                    self._cameraPosition._listener = self._Modified
                self._cameraPosition.reset()
                if cache:
                    self._cameraPosition._cached_serialization = bytes(memory[current_offset:current_offset+field_size])
                current_offset += self._cameraPosition._protobuf_deserialize(memory+current_offset, <int>field_size, cache)
            # cameraRotation
            elif key == 42:
                field_size = get_varint64(memory, &current_offset)
                if self._cameraRotation is None:
                    self._cameraRotation = Mat3.__new__(Mat3)
                    self._cameraRotation._listener = self._Modified
                self._cameraRotation.reset()
                if cache:
                    self._cameraRotation._cached_serialization = bytes(memory[current_offset:current_offset+field_size])
                current_offset += self._cameraRotation._protobuf_deserialize(memory+current_offset, <int>field_size, cache)
            # Unknown field - need to skip proper number of bytes
            else:
                assert skip_generic(memory, &current_offset, size, key & 0x7)

        self._is_present_in_parent = True

        return current_offset

    cpdef void Clear(self):
        """Clears all data that was set in the message."""
        self.reset()
        self._Modified()

    cpdef void ClearField(self, field_name):
        """Clears the contents of a given field."""
        self._clearfield(field_name)
        self._Modified()

    cdef void _clearfield(self, field_name):
        if field_name == 'avatarPosition':
            self._avatarPosition__reset()
        elif field_name == 'avatarRotation':
            self._avatarRotation__reset()
        elif field_name == 'animationPhase':
            self._animationPhase__reset()
        elif field_name == 'cameraPosition':
            self._cameraPosition__reset()
        elif field_name == 'cameraRotation':
            self._cameraRotation__reset()
        else:
            raise ValueError('Protocol message has no "%s" field.' % field_name)

    cpdef void CopyFrom(self, Avatar other_msg):
        """
        Copies the content of the specified message into the current message.

        Params:
            other_msg (Avatar): Message to copy into the current one.
        """
        if self is other_msg:
            return
        self.reset()
        self.MergeFrom(other_msg)

    cpdef bint HasField(self, field_name) except -1:
        """
        Checks if a certain field is set for the message.

        Params:
            field_name (str): The name of the field to check.
        """
        if field_name == 'avatarPosition':
            return self._avatarPosition is not None and self._avatarPosition._is_present_in_parent
        if field_name == 'avatarRotation':
            return self._avatarRotation is not None and self._avatarRotation._is_present_in_parent
        if field_name == 'animationPhase':
            return self.__field_bitmap0 & 4 == 4
        if field_name == 'cameraPosition':
            return self._cameraPosition is not None and self._cameraPosition._is_present_in_parent
        if field_name == 'cameraRotation':
            return self._cameraRotation is not None and self._cameraRotation._is_present_in_parent
        raise ValueError('Protocol message has no singular "%s" field.' % field_name)

    cpdef bint IsInitialized(self):
        """
        Checks if the message is initialized.

        Returns:
            bool: True if the message is initialized (i.e. all of its required
                fields are set).
        """

    

        return True

    cpdef void MergeFrom(self, Avatar other_msg):
        """
        Merges the contents of the specified message into the current message.

        Params:
            other_msg: Message to merge into the current message.
        """

        if self is other_msg:
            return

    
        if other_msg._avatarPosition is not None and other_msg._avatarPosition._is_present_in_parent:
            if self._avatarPosition is None:
                self._avatarPosition = Vec3.__new__(Vec3)
                self._avatarPosition.reset()
                self._avatarPosition._listener = self._Modified
            self._avatarPosition.MergeFrom(other_msg._avatarPosition)
        if other_msg._avatarRotation is not None and other_msg._avatarRotation._is_present_in_parent:
            if self._avatarRotation is None:
                self._avatarRotation = Vec3.__new__(Vec3)
                self._avatarRotation.reset()
                self._avatarRotation._listener = self._Modified
            self._avatarRotation.MergeFrom(other_msg._avatarRotation)
        if other_msg.__field_bitmap0 & 4 == 4:
            self._animationPhase = other_msg._animationPhase
            self.__field_bitmap0 |= 4
        if other_msg._cameraPosition is not None and other_msg._cameraPosition._is_present_in_parent:
            if self._cameraPosition is None:
                self._cameraPosition = Vec3.__new__(Vec3)
                self._cameraPosition.reset()
                self._cameraPosition._listener = self._Modified
            self._cameraPosition.MergeFrom(other_msg._cameraPosition)
        if other_msg._cameraRotation is not None and other_msg._cameraRotation._is_present_in_parent:
            if self._cameraRotation is None:
                self._cameraRotation = Mat3.__new__(Mat3)
                self._cameraRotation.reset()
                self._cameraRotation._listener = self._Modified
            self._cameraRotation.MergeFrom(other_msg._cameraRotation)

        self._Modified()

    cpdef int MergeFromString(self, data, size=None) except -1:
        """
        Merges serialized protocol buffer data into this message.

        Params:
            data (bytes): a string of binary data.
            size (int): optional - the length of the data string

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        buf = self._protobuf_deserialize(data, length, False)

        if buf != length:
            raise DecodeError("Truncated message: got %s expected %s" % (buf, size))

        self._Modified()

        return buf

    cpdef int ParseFromString(self, data, size=None, bint reset=True, bint cache=False) except -1:
        """
        Populate the message class from a string of protobuf encoded binary data.

        Params:
            data (bytes): a string of binary data
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
            cache (bool): optional - whether to cache serialized data

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        if reset:
            self.reset()

        buf = self._protobuf_deserialize(data, length, cache)

        if buf != length:
            raise DecodeError("Truncated message")

        self._Modified()

        if cache:
            self._cached_serialization = data

        return buf

    @classmethod
    def FromString(cls, s):
        message = cls()
        message.MergeFromString(s)
        return message

    cdef void _protobuf_serialize(self, bytearray buf, bint cache):
        # avatarPosition
        cdef bytearray avatarPosition_buf
        if self._avatarPosition is not None and self._avatarPosition._is_present_in_parent:
            set_varint64(10, buf)
            if self._avatarPosition._cached_serialization is not None:
                set_varint64(len(self._avatarPosition._cached_serialization), buf)
                buf += self._avatarPosition._cached_serialization
            else:
                avatarPosition_buf = bytearray()
                self._avatarPosition._protobuf_serialize(avatarPosition_buf, cache)
                set_varint64(len(avatarPosition_buf), buf)
                buf += avatarPosition_buf
                if cache:
                    self._avatarPosition._cached_serialization = bytes(avatarPosition_buf)
        # avatarRotation
        cdef bytearray avatarRotation_buf
        if self._avatarRotation is not None and self._avatarRotation._is_present_in_parent:
            set_varint64(18, buf)
            if self._avatarRotation._cached_serialization is not None:
                set_varint64(len(self._avatarRotation._cached_serialization), buf)
                buf += self._avatarRotation._cached_serialization
            else:
                avatarRotation_buf = bytearray()
                self._avatarRotation._protobuf_serialize(avatarRotation_buf, cache)
                set_varint64(len(avatarRotation_buf), buf)
                buf += avatarRotation_buf
                if cache:
                    self._avatarRotation._cached_serialization = bytes(avatarRotation_buf)
        # animationPhase
        if self.__field_bitmap0 & 4 == 4:
            set_varint64(25, buf)
            buf += (<unsigned char *>&self._animationPhase)[:sizeof(double)]
        # cameraPosition
        cdef bytearray cameraPosition_buf
        if self._cameraPosition is not None and self._cameraPosition._is_present_in_parent:
            set_varint64(34, buf)
            if self._cameraPosition._cached_serialization is not None:
                set_varint64(len(self._cameraPosition._cached_serialization), buf)
                buf += self._cameraPosition._cached_serialization
            else:
                cameraPosition_buf = bytearray()
                self._cameraPosition._protobuf_serialize(cameraPosition_buf, cache)
                set_varint64(len(cameraPosition_buf), buf)
                buf += cameraPosition_buf
                if cache:
                    self._cameraPosition._cached_serialization = bytes(cameraPosition_buf)
        # cameraRotation
        cdef bytearray cameraRotation_buf
        if self._cameraRotation is not None and self._cameraRotation._is_present_in_parent:
            set_varint64(42, buf)
            if self._cameraRotation._cached_serialization is not None:
                set_varint64(len(self._cameraRotation._cached_serialization), buf)
                buf += self._cameraRotation._cached_serialization
            else:
                cameraRotation_buf = bytearray()
                self._cameraRotation._protobuf_serialize(cameraRotation_buf, cache)
                set_varint64(len(cameraRotation_buf), buf)
                buf += cameraRotation_buf
                if cache:
                    self._cameraRotation._cached_serialization = bytes(cameraRotation_buf)

    cpdef void _Modified(self):
        self._is_present_in_parent = True
        self._listener()
        self._cached_serialization = None

    

    cpdef bytes SerializeToString(self, bint cache=False):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """

    

        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, cache)
        cdef bytes out = bytes(buf)

        if cache:
            self._cached_serialization = out

        return out

    cpdef bytes SerializePartialToString(self):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """
        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, False)
        return bytes(buf)

    def SetInParent(self):
        """
        Mark this an present in the parent.
        """
        self._Modified()

    def ParseFromJson(self, data, size=None, reset=True):
        """
        Populate the message class from a json string.

        Params:
            data (str): a json string
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
        """
        if size is None:
            size = len(data)
        d = json.loads(data[:size])
        self.ParseFromDict(d, reset)

    def SerializeToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializeToDict()
        return json.dumps(d, **kwargs)

    def SerializePartialToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializePartialToDict()
        return json.dumps(d, **kwargs)

    def ParseFromDict(self, d, reset=True):
        """
        Populate the message class from a Python dictionary.

        Params:
            d (dict): a Python dictionary representing the message
            reset (bool): optional - whether to reset to default values before serializing
        """
        if reset:
            self.reset()

        assert type(d) == dict
        try:
            self.avatarPosition.ParseFromDict(d["avatarPosition"])
        except KeyError:
            pass
        try:
            self.avatarRotation.ParseFromDict(d["avatarRotation"])
        except KeyError:
            pass
        try:
            self.animationPhase = d["animationPhase"]
        except KeyError:
            pass
        try:
            self.cameraPosition.ParseFromDict(d["cameraPosition"])
        except KeyError:
            pass
        try:
            self.cameraRotation.ParseFromDict(d["cameraRotation"])
        except KeyError:
            pass

        self._Modified()

        return

    def SerializeToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        avatarPosition_dict = self.avatarPosition.SerializeToDict()
        if avatarPosition_dict != {}:
            out["avatarPosition"] = avatarPosition_dict
        avatarRotation_dict = self.avatarRotation.SerializeToDict()
        if avatarRotation_dict != {}:
            out["avatarRotation"] = avatarRotation_dict
        if self.__field_bitmap0 & 4 == 4:
            out["animationPhase"] = self.animationPhase
        cameraPosition_dict = self.cameraPosition.SerializeToDict()
        if cameraPosition_dict != {}:
            out["cameraPosition"] = cameraPosition_dict
        cameraRotation_dict = self.cameraRotation.SerializeToDict()
        if cameraRotation_dict != {}:
            out["cameraRotation"] = cameraRotation_dict

        return out

    def SerializePartialToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        avatarPosition_dict = self.avatarPosition.SerializePartialToDict()
        if avatarPosition_dict != {}:
            out["avatarPosition"] = avatarPosition_dict
        avatarRotation_dict = self.avatarRotation.SerializePartialToDict()
        if avatarRotation_dict != {}:
            out["avatarRotation"] = avatarRotation_dict
        if self.__field_bitmap0 & 4 == 4:
            out["animationPhase"] = self.animationPhase
        cameraPosition_dict = self.cameraPosition.SerializePartialToDict()
        if cameraPosition_dict != {}:
            out["cameraPosition"] = cameraPosition_dict
        cameraRotation_dict = self.cameraRotation.SerializePartialToDict()
        if cameraRotation_dict != {}:
            out["cameraRotation"] = cameraRotation_dict

        return out

    def Items(self):
        """
        Iterator over the field names and values of the message.

        Returns:
            iterator
        """
        yield 'avatarPosition', self.avatarPosition
        yield 'avatarRotation', self.avatarRotation
        yield 'animationPhase', self.animationPhase
        yield 'cameraPosition', self.cameraPosition
        yield 'cameraRotation', self.cameraRotation

    def Fields(self):
        """
        Iterator over the field names of the message.

        Returns:
            iterator
        """
        yield 'avatarPosition'
        yield 'avatarRotation'
        yield 'animationPhase'
        yield 'cameraPosition'
        yield 'cameraRotation'

    def Values(self):
        """
        Iterator over the values of the message.

        Returns:
            iterator
        """
        yield self.avatarPosition
        yield self.avatarRotation
        yield self.animationPhase
        yield self.cameraPosition
        yield self.cameraRotation

    

    def Setters(self):
        """
        Iterator over functions to set the fields in a message.

        Returns:
            iterator
        """
        def setter(value):
            self.avatarPosition = value
        yield setter
        def setter(value):
            self.avatarRotation = value
        yield setter
        def setter(value):
            self.animationPhase = value
        yield setter
        def setter(value):
            self.cameraPosition = value
        yield setter
        def setter(value):
            self.cameraRotation = value
        yield setter

    


cdef class Menu:

    def __cinit__(self):
        self._listener = noop_listener

    def __dealloc__(self):
        # Remove any references to self from child messages or repeated fields
        if self._entries is not None:
            self._entries._listener = noop_listener

    def __init__(self, **kwargs):
        self.reset()
        if kwargs:
            for field_name, field_value in kwargs.items():
                try:
                    if field_name in ('entries',):
                        getattr(self, field_name).extend(field_value)
                    else:
                        setattr(self, field_name, field_value)
                except AttributeError:
                    raise ValueError('Protocol message has no "%s" field.' % (field_name,))
        return

    def __str__(self):
        fields = [
                          'entries',
                          'activeEntryIndex',]
        components = ['{0}: {1}'.format(field, getattr(self, field)) for field in fields]
        messages = []
        for message in messages:
            components.append('{0}: {{'.format(message))
            for line in str(getattr(self, message)).split('\n'):
                components.append('  {0}'.format(line))
            components.append('}')
        return '\n'.join(components)

    
    cpdef _entries__reset(self):
        if self._entries is not None:
            self._entries._listener = noop_listener
        self._entries = StringList.__new__(StringList)
        self._entries._listener = self._Modified
    cpdef _activeEntryIndex__reset(self):
        self._activeEntryIndex = 0
        self.__field_bitmap0 &= ~2

    cpdef void reset(self):
        # reset values and populate defaults
    
        self._entries__reset()
        self._activeEntryIndex__reset()
        return

    
    @property
    def entries(self):
        return self._entries

    @entries.setter
    def entries(self, value):
        if self._entries is not None:
            self._entries._listener = noop_listener
        self._entries = StringList.__new__(StringList)
        self._entries._listener = self._Modified
        for val in value:
            if isinstance(val, bytes):
                list.append(self._entries, val.decode('utf-8'))
            elif isinstance(val, str):
                list.append(self._entries, val)
            else:
                raise TypeError("%r has type %s, but expected one of: (%s, %s)" % (val, type(val), bytes, str))
        self._Modified()
    
    @property
    def activeEntryIndex(self):
        return self._activeEntryIndex

    @activeEntryIndex.setter
    def activeEntryIndex(self, value):
        self.__field_bitmap0 |= 2
        self._activeEntryIndex = value
        self._Modified()
    

    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache):
        cdef int current_offset = 0
        cdef int64_t key
        cdef int64_t field_size
        cdef str entries_elt
        while current_offset < size:
            key = get_varint64(memory, &current_offset)
            # entries
            if key == 10:
                field_size = get_varint64(memory, &current_offset)
                entries_elt = str(memory[current_offset:current_offset + field_size], 'utf-8')
                current_offset += <int>field_size
                list.append(self._entries, entries_elt)
            # activeEntryIndex
            elif key == 16:
                self.__field_bitmap0 |= 2
                self._activeEntryIndex = get_varint32(memory, &current_offset)
            # Unknown field - need to skip proper number of bytes
            else:
                assert skip_generic(memory, &current_offset, size, key & 0x7)

        self._is_present_in_parent = True

        return current_offset

    cpdef void Clear(self):
        """Clears all data that was set in the message."""
        self.reset()
        self._Modified()

    cpdef void ClearField(self, field_name):
        """Clears the contents of a given field."""
        self._clearfield(field_name)
        self._Modified()

    cdef void _clearfield(self, field_name):
        if field_name == 'entries':
            self._entries__reset()
        elif field_name == 'activeEntryIndex':
            self._activeEntryIndex__reset()
        else:
            raise ValueError('Protocol message has no "%s" field.' % field_name)

    cpdef void CopyFrom(self, Menu other_msg):
        """
        Copies the content of the specified message into the current message.

        Params:
            other_msg (Menu): Message to copy into the current one.
        """
        if self is other_msg:
            return
        self.reset()
        self.MergeFrom(other_msg)

    cpdef bint HasField(self, field_name) except -1:
        """
        Checks if a certain field is set for the message.

        Params:
            field_name (str): The name of the field to check.
        """
        if field_name == 'activeEntryIndex':
            return self.__field_bitmap0 & 2 == 2
        raise ValueError('Protocol message has no singular "%s" field.' % field_name)

    cpdef bint IsInitialized(self):
        """
        Checks if the message is initialized.

        Returns:
            bool: True if the message is initialized (i.e. all of its required
                fields are set).
        """

    

        return True

    cpdef void MergeFrom(self, Menu other_msg):
        """
        Merges the contents of the specified message into the current message.

        Params:
            other_msg: Message to merge into the current message.
        """
        cdef int i

        if self is other_msg:
            return

    
        self._entries += other_msg._entries
        if other_msg.__field_bitmap0 & 2 == 2:
            self._activeEntryIndex = other_msg._activeEntryIndex
            self.__field_bitmap0 |= 2

        self._Modified()

    cpdef int MergeFromString(self, data, size=None) except -1:
        """
        Merges serialized protocol buffer data into this message.

        Params:
            data (bytes): a string of binary data.
            size (int): optional - the length of the data string

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        buf = self._protobuf_deserialize(data, length, False)

        if buf != length:
            raise DecodeError("Truncated message: got %s expected %s" % (buf, size))

        self._Modified()

        return buf

    cpdef int ParseFromString(self, data, size=None, bint reset=True, bint cache=False) except -1:
        """
        Populate the message class from a string of protobuf encoded binary data.

        Params:
            data (bytes): a string of binary data
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
            cache (bool): optional - whether to cache serialized data

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        if reset:
            self.reset()

        buf = self._protobuf_deserialize(data, length, cache)

        if buf != length:
            raise DecodeError("Truncated message")

        self._Modified()

        if cache:
            self._cached_serialization = data

        return buf

    @classmethod
    def FromString(cls, s):
        message = cls()
        message.MergeFromString(s)
        return message

    cdef void _protobuf_serialize(self, bytearray buf, bint cache):
        cdef ssize_t length
        # entries
        cdef str entries_elt
        cdef bytes entries_elt_bytes
        for entries_elt in self._entries:
            set_varint64(10, buf)
            entries_elt_bytes = entries_elt.encode('utf-8')
            set_varint64(len(entries_elt_bytes), buf)
            buf += entries_elt_bytes
        # activeEntryIndex
        if self.__field_bitmap0 & 2 == 2:
            set_varint64(16, buf)
            set_varint32(self._activeEntryIndex, buf)

    cpdef void _Modified(self):
        self._is_present_in_parent = True
        self._listener()
        self._cached_serialization = None

    

    cpdef bytes SerializeToString(self, bint cache=False):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """

    

        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, cache)
        cdef bytes out = bytes(buf)

        if cache:
            self._cached_serialization = out

        return out

    cpdef bytes SerializePartialToString(self):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """
        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, False)
        return bytes(buf)

    def SetInParent(self):
        """
        Mark this an present in the parent.
        """
        self._Modified()

    def ParseFromJson(self, data, size=None, reset=True):
        """
        Populate the message class from a json string.

        Params:
            data (str): a json string
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
        """
        if size is None:
            size = len(data)
        d = json.loads(data[:size])
        self.ParseFromDict(d, reset)

    def SerializeToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializeToDict()
        return json.dumps(d, **kwargs)

    def SerializePartialToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializePartialToDict()
        return json.dumps(d, **kwargs)

    def ParseFromDict(self, d, reset=True):
        """
        Populate the message class from a Python dictionary.

        Params:
            d (dict): a Python dictionary representing the message
            reset (bool): optional - whether to reset to default values before serializing
        """
        if reset:
            self.reset()

        assert type(d) == dict
        try:
            self.entries = d["entries"]
        except KeyError:
            pass
        try:
            self.activeEntryIndex = d["activeEntryIndex"]
        except KeyError:
            pass

        self._Modified()

        return

    def SerializeToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        if len(self.entries) > 0:
            out["entries"] = list(self.entries)
        if self.__field_bitmap0 & 2 == 2:
            out["activeEntryIndex"] = self.activeEntryIndex

        return out

    def SerializePartialToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        if len(self.entries) > 0:
            out["entries"] = list(self.entries)
        if self.__field_bitmap0 & 2 == 2:
            out["activeEntryIndex"] = self.activeEntryIndex

        return out

    def Items(self):
        """
        Iterator over the field names and values of the message.

        Returns:
            iterator
        """
        yield 'entries', self.entries
        yield 'activeEntryIndex', self.activeEntryIndex

    def Fields(self):
        """
        Iterator over the field names of the message.

        Returns:
            iterator
        """
        yield 'entries'
        yield 'activeEntryIndex'

    def Values(self):
        """
        Iterator over the values of the message.

        Returns:
            iterator
        """
        yield self.entries
        yield self.activeEntryIndex

    

    def Setters(self):
        """
        Iterator over functions to set the fields in a message.

        Returns:
            iterator
        """
        def setter(value):
            self.entries = value
        yield setter
        def setter(value):
            self.activeEntryIndex = value
        yield setter

    


cdef class Banner:

    def __cinit__(self):
        self._listener = noop_listener

    def __dealloc__(self):
        # Remove any references to self from child messages or repeated fields
        if self._lines is not None:
            self._lines._listener = noop_listener

    def __init__(self, **kwargs):
        self.reset()
        if kwargs:
            for field_name, field_value in kwargs.items():
                try:
                    if field_name in ('lines',):
                        getattr(self, field_name).extend(field_value)
                    else:
                        setattr(self, field_name, field_value)
                except AttributeError:
                    raise ValueError('Protocol message has no "%s" field.' % (field_name,))
        return

    def __str__(self):
        fields = [
                          'lines',
                          'position',]
        components = ['{0}: {1}'.format(field, getattr(self, field)) for field in fields]
        messages = []
        for message in messages:
            components.append('{0}: {{'.format(message))
            for line in str(getattr(self, message)).split('\n'):
                components.append('  {0}'.format(line))
            components.append('}')
        return '\n'.join(components)

    
    cpdef _lines__reset(self):
        if self._lines is not None:
            self._lines._listener = noop_listener
        self._lines = StringList.__new__(StringList)
        self._lines._listener = self._Modified
    cpdef _position__reset(self):
        self._position = _BannerPosition_TOP
        self.__field_bitmap0 &= ~2

    cpdef void reset(self):
        # reset values and populate defaults
    
        self._lines__reset()
        self._position__reset()
        return

    
    @property
    def lines(self):
        return self._lines

    @lines.setter
    def lines(self, value):
        if self._lines is not None:
            self._lines._listener = noop_listener
        self._lines = StringList.__new__(StringList)
        self._lines._listener = self._Modified
        for val in value:
            if isinstance(val, bytes):
                list.append(self._lines, val.decode('utf-8'))
            elif isinstance(val, str):
                list.append(self._lines, val)
            else:
                raise TypeError("%r has type %s, but expected one of: (%s, %s)" % (val, type(val), bytes, str))
        self._Modified()
    
    @property
    def position(self):
        return self._position

    @position.setter
    def position(self, value):
        self.__field_bitmap0 |= 2
        if value == 0:
            self._position = _BannerPosition_TOP
                
        elif value == 1:
            self._position = _BannerPosition_CENTER
                
        else:
            raise ValueError("{} not a valid value for enum BannerPosition".format(value))
        self._Modified()
    

    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache):
        cdef int current_offset = 0
        cdef int64_t key
        cdef int64_t field_size
        cdef str lines_elt
        while current_offset < size:
            key = get_varint64(memory, &current_offset)
            # lines
            if key == 10:
                field_size = get_varint64(memory, &current_offset)
                lines_elt = str(memory[current_offset:current_offset + field_size], 'utf-8')
                current_offset += <int>field_size
                list.append(self._lines, lines_elt)
            # position
            elif key == 16:
                self.position = get_varint32(memory, &current_offset)
            # Unknown field - need to skip proper number of bytes
            else:
                assert skip_generic(memory, &current_offset, size, key & 0x7)

        self._is_present_in_parent = True

        return current_offset

    cpdef void Clear(self):
        """Clears all data that was set in the message."""
        self.reset()
        self._Modified()

    cpdef void ClearField(self, field_name):
        """Clears the contents of a given field."""
        self._clearfield(field_name)
        self._Modified()

    cdef void _clearfield(self, field_name):
        if field_name == 'lines':
            self._lines__reset()
        elif field_name == 'position':
            self._position__reset()
        else:
            raise ValueError('Protocol message has no "%s" field.' % field_name)

    cpdef void CopyFrom(self, Banner other_msg):
        """
        Copies the content of the specified message into the current message.

        Params:
            other_msg (Banner): Message to copy into the current one.
        """
        if self is other_msg:
            return
        self.reset()
        self.MergeFrom(other_msg)

    cpdef bint HasField(self, field_name) except -1:
        """
        Checks if a certain field is set for the message.

        Params:
            field_name (str): The name of the field to check.
        """
        if field_name == 'position':
            return self.__field_bitmap0 & 2 == 2
        raise ValueError('Protocol message has no singular "%s" field.' % field_name)

    cpdef bint IsInitialized(self):
        """
        Checks if the message is initialized.

        Returns:
            bool: True if the message is initialized (i.e. all of its required
                fields are set).
        """

    

        return True

    cpdef void MergeFrom(self, Banner other_msg):
        """
        Merges the contents of the specified message into the current message.

        Params:
            other_msg: Message to merge into the current message.
        """
        cdef int i

        if self is other_msg:
            return

    
        self._lines += other_msg._lines
        if other_msg.__field_bitmap0 & 2 == 2:
            self._position = other_msg._position
            self.__field_bitmap0 |= 2

        self._Modified()

    cpdef int MergeFromString(self, data, size=None) except -1:
        """
        Merges serialized protocol buffer data into this message.

        Params:
            data (bytes): a string of binary data.
            size (int): optional - the length of the data string

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        buf = self._protobuf_deserialize(data, length, False)

        if buf != length:
            raise DecodeError("Truncated message: got %s expected %s" % (buf, size))

        self._Modified()

        return buf

    cpdef int ParseFromString(self, data, size=None, bint reset=True, bint cache=False) except -1:
        """
        Populate the message class from a string of protobuf encoded binary data.

        Params:
            data (bytes): a string of binary data
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
            cache (bool): optional - whether to cache serialized data

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        if reset:
            self.reset()

        buf = self._protobuf_deserialize(data, length, cache)

        if buf != length:
            raise DecodeError("Truncated message")

        self._Modified()

        if cache:
            self._cached_serialization = data

        return buf

    @classmethod
    def FromString(cls, s):
        message = cls()
        message.MergeFromString(s)
        return message

    cdef void _protobuf_serialize(self, bytearray buf, bint cache):
        cdef ssize_t length
        # lines
        cdef str lines_elt
        cdef bytes lines_elt_bytes
        for lines_elt in self._lines:
            set_varint64(10, buf)
            lines_elt_bytes = lines_elt.encode('utf-8')
            set_varint64(len(lines_elt_bytes), buf)
            buf += lines_elt_bytes
        # position
        if self.__field_bitmap0 & 2 == 2:
            set_varint64(16, buf)
            set_varint32(self._position, buf)

    cpdef void _Modified(self):
        self._is_present_in_parent = True
        self._listener()
        self._cached_serialization = None

    

    cpdef bytes SerializeToString(self, bint cache=False):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """

    

        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, cache)
        cdef bytes out = bytes(buf)

        if cache:
            self._cached_serialization = out

        return out

    cpdef bytes SerializePartialToString(self):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """
        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, False)
        return bytes(buf)

    def SetInParent(self):
        """
        Mark this an present in the parent.
        """
        self._Modified()

    def ParseFromJson(self, data, size=None, reset=True):
        """
        Populate the message class from a json string.

        Params:
            data (str): a json string
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
        """
        if size is None:
            size = len(data)
        d = json.loads(data[:size])
        self.ParseFromDict(d, reset)

    def SerializeToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializeToDict()
        return json.dumps(d, **kwargs)

    def SerializePartialToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializePartialToDict()
        return json.dumps(d, **kwargs)

    def ParseFromDict(self, d, reset=True):
        """
        Populate the message class from a Python dictionary.

        Params:
            d (dict): a Python dictionary representing the message
            reset (bool): optional - whether to reset to default values before serializing
        """
        if reset:
            self.reset()

        assert type(d) == dict
        try:
            self.lines = d["lines"]
        except KeyError:
            pass
        try:
            self.position = d["position"]
        except KeyError:
            pass

        self._Modified()

        return

    def SerializeToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        if len(self.lines) > 0:
            out["lines"] = list(self.lines)
        if self.__field_bitmap0 & 2 == 2:
            out["position"] = self.position

        return out

    def SerializePartialToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        if len(self.lines) > 0:
            out["lines"] = list(self.lines)
        if self.__field_bitmap0 & 2 == 2:
            out["position"] = self.position

        return out

    def Items(self):
        """
        Iterator over the field names and values of the message.

        Returns:
            iterator
        """
        yield 'lines', self.lines
        yield 'position', self.position

    def Fields(self):
        """
        Iterator over the field names of the message.

        Returns:
            iterator
        """
        yield 'lines'
        yield 'position'

    def Values(self):
        """
        Iterator over the values of the message.

        Returns:
            iterator
        """
        yield self.lines
        yield self.position

    
        
    TOP = _BannerPosition_TOP
    CENTER = _BannerPosition_CENTER
    

    def Setters(self):
        """
        Iterator over functions to set the fields in a message.

        Returns:
            iterator
        """
        def setter(value):
            self.lines = value
        yield setter
        def setter(value):
            self.position = value
        yield setter

    


cdef class Legend:

    def __cinit__(self):
        self._listener = noop_listener

    

    def __init__(self, **kwargs):
        self.reset()
        if kwargs:
            for field_name, field_value in kwargs.items():
                try:
                    setattr(self, field_name, field_value)
                except AttributeError:
                    raise ValueError('Protocol message has no "%s" field.' % (field_name,))
        return

    def __str__(self):
        fields = [
                          'upActive',
                          'selectActive',
                          'downActive',]
        components = ['{0}: {1}'.format(field, getattr(self, field)) for field in fields]
        messages = []
        for message in messages:
            components.append('{0}: {{'.format(message))
            for line in str(getattr(self, message)).split('\n'):
                components.append('  {0}'.format(line))
            components.append('}')
        return '\n'.join(components)

    
    cpdef _upActive__reset(self):
        self._upActive = 0
        self.__field_bitmap0 &= ~1
    cpdef _selectActive__reset(self):
        self._selectActive = 0
        self.__field_bitmap0 &= ~2
    cpdef _downActive__reset(self):
        self._downActive = 0
        self.__field_bitmap0 &= ~4

    cpdef void reset(self):
        # reset values and populate defaults
    
        self._upActive__reset()
        self._selectActive__reset()
        self._downActive__reset()
        return

    
    @property
    def upActive(self):
        return self._upActive

    @upActive.setter
    def upActive(self, value):
        self.__field_bitmap0 |= 1
        self._upActive = value
        self._Modified()
    
    @property
    def selectActive(self):
        return self._selectActive

    @selectActive.setter
    def selectActive(self, value):
        self.__field_bitmap0 |= 2
        self._selectActive = value
        self._Modified()
    
    @property
    def downActive(self):
        return self._downActive

    @downActive.setter
    def downActive(self, value):
        self.__field_bitmap0 |= 4
        self._downActive = value
        self._Modified()
    

    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache):
        cdef int current_offset = 0
        cdef int64_t key
        while current_offset < size:
            key = get_varint64(memory, &current_offset)
            # upActive
            if key == 8:
                self.__field_bitmap0 |= 1
                self._upActive = get_varint32(memory, &current_offset)
            # selectActive
            elif key == 16:
                self.__field_bitmap0 |= 2
                self._selectActive = get_varint32(memory, &current_offset)
            # downActive
            elif key == 24:
                self.__field_bitmap0 |= 4
                self._downActive = get_varint32(memory, &current_offset)
            # Unknown field - need to skip proper number of bytes
            else:
                assert skip_generic(memory, &current_offset, size, key & 0x7)

        self._is_present_in_parent = True

        return current_offset

    cpdef void Clear(self):
        """Clears all data that was set in the message."""
        self.reset()
        self._Modified()

    cpdef void ClearField(self, field_name):
        """Clears the contents of a given field."""
        self._clearfield(field_name)
        self._Modified()

    cdef void _clearfield(self, field_name):
        if field_name == 'upActive':
            self._upActive__reset()
        elif field_name == 'selectActive':
            self._selectActive__reset()
        elif field_name == 'downActive':
            self._downActive__reset()
        else:
            raise ValueError('Protocol message has no "%s" field.' % field_name)

    cpdef void CopyFrom(self, Legend other_msg):
        """
        Copies the content of the specified message into the current message.

        Params:
            other_msg (Legend): Message to copy into the current one.
        """
        if self is other_msg:
            return
        self.reset()
        self.MergeFrom(other_msg)

    cpdef bint HasField(self, field_name) except -1:
        """
        Checks if a certain field is set for the message.

        Params:
            field_name (str): The name of the field to check.
        """
        if field_name == 'upActive':
            return self.__field_bitmap0 & 1 == 1
        if field_name == 'selectActive':
            return self.__field_bitmap0 & 2 == 2
        if field_name == 'downActive':
            return self.__field_bitmap0 & 4 == 4
        raise ValueError('Protocol message has no singular "%s" field.' % field_name)

    cpdef bint IsInitialized(self):
        """
        Checks if the message is initialized.

        Returns:
            bool: True if the message is initialized (i.e. all of its required
                fields are set).
        """

    

        return True

    cpdef void MergeFrom(self, Legend other_msg):
        """
        Merges the contents of the specified message into the current message.

        Params:
            other_msg: Message to merge into the current message.
        """

        if self is other_msg:
            return

    
        if other_msg.__field_bitmap0 & 1 == 1:
            self._upActive = other_msg._upActive
            self.__field_bitmap0 |= 1
        if other_msg.__field_bitmap0 & 2 == 2:
            self._selectActive = other_msg._selectActive
            self.__field_bitmap0 |= 2
        if other_msg.__field_bitmap0 & 4 == 4:
            self._downActive = other_msg._downActive
            self.__field_bitmap0 |= 4

        self._Modified()

    cpdef int MergeFromString(self, data, size=None) except -1:
        """
        Merges serialized protocol buffer data into this message.

        Params:
            data (bytes): a string of binary data.
            size (int): optional - the length of the data string

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        buf = self._protobuf_deserialize(data, length, False)

        if buf != length:
            raise DecodeError("Truncated message: got %s expected %s" % (buf, size))

        self._Modified()

        return buf

    cpdef int ParseFromString(self, data, size=None, bint reset=True, bint cache=False) except -1:
        """
        Populate the message class from a string of protobuf encoded binary data.

        Params:
            data (bytes): a string of binary data
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
            cache (bool): optional - whether to cache serialized data

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        if reset:
            self.reset()

        buf = self._protobuf_deserialize(data, length, cache)

        if buf != length:
            raise DecodeError("Truncated message")

        self._Modified()

        if cache:
            self._cached_serialization = data

        return buf

    @classmethod
    def FromString(cls, s):
        message = cls()
        message.MergeFromString(s)
        return message

    cdef void _protobuf_serialize(self, bytearray buf, bint cache):
        # upActive
        if self.__field_bitmap0 & 1 == 1:
            set_varint64(8, buf)
            set_varint32(self._upActive, buf)
        # selectActive
        if self.__field_bitmap0 & 2 == 2:
            set_varint64(16, buf)
            set_varint32(self._selectActive, buf)
        # downActive
        if self.__field_bitmap0 & 4 == 4:
            set_varint64(24, buf)
            set_varint32(self._downActive, buf)

    cpdef void _Modified(self):
        self._is_present_in_parent = True
        self._listener()
        self._cached_serialization = None

    

    cpdef bytes SerializeToString(self, bint cache=False):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """

    

        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, cache)
        cdef bytes out = bytes(buf)

        if cache:
            self._cached_serialization = out

        return out

    cpdef bytes SerializePartialToString(self):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """
        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, False)
        return bytes(buf)

    def SetInParent(self):
        """
        Mark this an present in the parent.
        """
        self._Modified()

    def ParseFromJson(self, data, size=None, reset=True):
        """
        Populate the message class from a json string.

        Params:
            data (str): a json string
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
        """
        if size is None:
            size = len(data)
        d = json.loads(data[:size])
        self.ParseFromDict(d, reset)

    def SerializeToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializeToDict()
        return json.dumps(d, **kwargs)

    def SerializePartialToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializePartialToDict()
        return json.dumps(d, **kwargs)

    def ParseFromDict(self, d, reset=True):
        """
        Populate the message class from a Python dictionary.

        Params:
            d (dict): a Python dictionary representing the message
            reset (bool): optional - whether to reset to default values before serializing
        """
        if reset:
            self.reset()

        assert type(d) == dict
        try:
            self.upActive = d["upActive"]
        except KeyError:
            pass
        try:
            self.selectActive = d["selectActive"]
        except KeyError:
            pass
        try:
            self.downActive = d["downActive"]
        except KeyError:
            pass

        self._Modified()

        return

    def SerializeToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        if self.__field_bitmap0 & 1 == 1:
            out["upActive"] = self.upActive
        if self.__field_bitmap0 & 2 == 2:
            out["selectActive"] = self.selectActive
        if self.__field_bitmap0 & 4 == 4:
            out["downActive"] = self.downActive

        return out

    def SerializePartialToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        if self.__field_bitmap0 & 1 == 1:
            out["upActive"] = self.upActive
        if self.__field_bitmap0 & 2 == 2:
            out["selectActive"] = self.selectActive
        if self.__field_bitmap0 & 4 == 4:
            out["downActive"] = self.downActive

        return out

    def Items(self):
        """
        Iterator over the field names and values of the message.

        Returns:
            iterator
        """
        yield 'upActive', self.upActive
        yield 'selectActive', self.selectActive
        yield 'downActive', self.downActive

    def Fields(self):
        """
        Iterator over the field names of the message.

        Returns:
            iterator
        """
        yield 'upActive'
        yield 'selectActive'
        yield 'downActive'

    def Values(self):
        """
        Iterator over the values of the message.

        Returns:
            iterator
        """
        yield self.upActive
        yield self.selectActive
        yield self.downActive

    

    def Setters(self):
        """
        Iterator over functions to set the fields in a message.

        Returns:
            iterator
        """
        def setter(value):
            self.upActive = value
        yield setter
        def setter(value):
            self.selectActive = value
        yield setter
        def setter(value):
            self.downActive = value
        yield setter

    


cdef class Frame:

    def __cinit__(self):
        self._listener = noop_listener

    def __dealloc__(self):
        # Remove any references to self from child messages or repeated fields
        if self._avatar is not None:
            self._avatar._listener = noop_listener
        if self._legend is not None:
            self._legend._listener = noop_listener
        if self._menu is not None:
            self._menu._listener = noop_listener
        if self._banner is not None:
            self._banner._listener = noop_listener

    def __init__(self, **kwargs):
        self.reset()
        if kwargs:
            for field_name, field_value in kwargs.items():
                try:
                    if field_name in ('avatar','legend','menu','banner',):
                        getattr(self, field_name).MergeFrom(field_value)
                    else:
                        setattr(self, field_name, field_value)
                except AttributeError:
                    raise ValueError('Protocol message has no "%s" field.' % (field_name,))
        return

    def __str__(self):
        fields = []
        components = ['{0}: {1}'.format(field, getattr(self, field)) for field in fields]
        messages = [
                            'avatar',
                            'legend',
                            'menu',
                            'banner',]
        for message in messages:
            components.append('{0}: {{'.format(message))
            for line in str(getattr(self, message)).split('\n'):
                components.append('  {0}'.format(line))
            components.append('}')
        return '\n'.join(components)

    
    cpdef _avatar__reset(self):
        if self._avatar is not None:
            self._avatar._listener = noop_listener
        self._avatar = None
    cpdef _legend__reset(self):
        if self._legend is not None:
            self._legend._listener = noop_listener
        self._legend = None
    cpdef _menu__reset(self):
        if self._menu is not None:
            self._menu._listener = noop_listener
        self._menu = None
    cpdef _banner__reset(self):
        if self._banner is not None:
            self._banner._listener = noop_listener
        self._banner = None

    cpdef void reset(self):
        # reset values and populate defaults
    
        self._avatar__reset()
        self._legend__reset()
        self._menu__reset()
        self._banner__reset()
        return

    
    @property
    def avatar(self):
        # lazy init sub messages
        if self._avatar is None:
            self._avatar = Avatar.__new__(Avatar)
            self._avatar.reset()
            self._avatar._listener = self._Modified
            self._listener()
        return self._avatar

    @avatar.setter
    def avatar(self, value):
        if self._avatar is not None:
            self._avatar._listener = noop_listener
        self._avatar = value
        self._avatar._listener = self._Modified
        self._Modified()
    
    @property
    def legend(self):
        # lazy init sub messages
        if self._legend is None:
            self._legend = Legend.__new__(Legend)
            self._legend.reset()
            self._legend._listener = self._Modified
            self._listener()
        return self._legend

    @legend.setter
    def legend(self, value):
        if self._legend is not None:
            self._legend._listener = noop_listener
        self._legend = value
        self._legend._listener = self._Modified
        self._Modified()
    
    @property
    def menu(self):
        # lazy init sub messages
        if self._menu is None:
            self._menu = Menu.__new__(Menu)
            self._menu.reset()
            self._menu._listener = self._Modified
            self._listener()
        return self._menu

    @menu.setter
    def menu(self, value):
        if self._menu is not None:
            self._menu._listener = noop_listener
        self._menu = value
        self._menu._listener = self._Modified
        self._Modified()
    
    @property
    def banner(self):
        # lazy init sub messages
        if self._banner is None:
            self._banner = Banner.__new__(Banner)
            self._banner.reset()
            self._banner._listener = self._Modified
            self._listener()
        return self._banner

    @banner.setter
    def banner(self, value):
        if self._banner is not None:
            self._banner._listener = noop_listener
        self._banner = value
        self._banner._listener = self._Modified
        self._Modified()
    

    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache):
        cdef int current_offset = 0
        cdef int64_t key
        cdef int64_t field_size
        while current_offset < size:
            key = get_varint64(memory, &current_offset)
            # avatar
            if key == 10:
                field_size = get_varint64(memory, &current_offset)
                if self._avatar is None:
                    self._avatar = Avatar.__new__(Avatar)
                    self._avatar._listener = self._Modified
                self._avatar.reset()
                if cache:
                    self._avatar._cached_serialization = bytes(memory[current_offset:current_offset+field_size])
                current_offset += self._avatar._protobuf_deserialize(memory+current_offset, <int>field_size, cache)
            # legend
            elif key == 18:
                field_size = get_varint64(memory, &current_offset)
                if self._legend is None:
                    self._legend = Legend.__new__(Legend)
                    self._legend._listener = self._Modified
                self._legend.reset()
                if cache:
                    self._legend._cached_serialization = bytes(memory[current_offset:current_offset+field_size])
                current_offset += self._legend._protobuf_deserialize(memory+current_offset, <int>field_size, cache)
            # menu
            elif key == 26:
                field_size = get_varint64(memory, &current_offset)
                if self._menu is None:
                    self._menu = Menu.__new__(Menu)
                    self._menu._listener = self._Modified
                self._menu.reset()
                if cache:
                    self._menu._cached_serialization = bytes(memory[current_offset:current_offset+field_size])
                current_offset += self._menu._protobuf_deserialize(memory+current_offset, <int>field_size, cache)
            # banner
            elif key == 34:
                field_size = get_varint64(memory, &current_offset)
                if self._banner is None:
                    self._banner = Banner.__new__(Banner)
                    self._banner._listener = self._Modified
                self._banner.reset()
                if cache:
                    self._banner._cached_serialization = bytes(memory[current_offset:current_offset+field_size])
                current_offset += self._banner._protobuf_deserialize(memory+current_offset, <int>field_size, cache)
            # Unknown field - need to skip proper number of bytes
            else:
                assert skip_generic(memory, &current_offset, size, key & 0x7)

        self._is_present_in_parent = True

        return current_offset

    cpdef void Clear(self):
        """Clears all data that was set in the message."""
        self.reset()
        self._Modified()

    cpdef void ClearField(self, field_name):
        """Clears the contents of a given field."""
        self._clearfield(field_name)
        self._Modified()

    cdef void _clearfield(self, field_name):
        if field_name == 'avatar':
            self._avatar__reset()
        elif field_name == 'legend':
            self._legend__reset()
        elif field_name == 'menu':
            self._menu__reset()
        elif field_name == 'banner':
            self._banner__reset()
        else:
            raise ValueError('Protocol message has no "%s" field.' % field_name)

    cpdef void CopyFrom(self, Frame other_msg):
        """
        Copies the content of the specified message into the current message.

        Params:
            other_msg (Frame): Message to copy into the current one.
        """
        if self is other_msg:
            return
        self.reset()
        self.MergeFrom(other_msg)

    cpdef bint HasField(self, field_name) except -1:
        """
        Checks if a certain field is set for the message.

        Params:
            field_name (str): The name of the field to check.
        """
        if field_name == 'avatar':
            return self._avatar is not None and self._avatar._is_present_in_parent
        if field_name == 'legend':
            return self._legend is not None and self._legend._is_present_in_parent
        if field_name == 'menu':
            return self._menu is not None and self._menu._is_present_in_parent
        if field_name == 'banner':
            return self._banner is not None and self._banner._is_present_in_parent
        raise ValueError('Protocol message has no singular "%s" field.' % field_name)

    cpdef bint IsInitialized(self):
        """
        Checks if the message is initialized.

        Returns:
            bool: True if the message is initialized (i.e. all of its required
                fields are set).
        """

    

        return True

    cpdef void MergeFrom(self, Frame other_msg):
        """
        Merges the contents of the specified message into the current message.

        Params:
            other_msg: Message to merge into the current message.
        """

        if self is other_msg:
            return

    
        if other_msg._avatar is not None and other_msg._avatar._is_present_in_parent:
            if self._avatar is None:
                self._avatar = Avatar.__new__(Avatar)
                self._avatar.reset()
                self._avatar._listener = self._Modified
            self._avatar.MergeFrom(other_msg._avatar)
        if other_msg._legend is not None and other_msg._legend._is_present_in_parent:
            if self._legend is None:
                self._legend = Legend.__new__(Legend)
                self._legend.reset()
                self._legend._listener = self._Modified
            self._legend.MergeFrom(other_msg._legend)
        if other_msg._menu is not None and other_msg._menu._is_present_in_parent:
            if self._menu is None:
                self._menu = Menu.__new__(Menu)
                self._menu.reset()
                self._menu._listener = self._Modified
            self._menu.MergeFrom(other_msg._menu)
        if other_msg._banner is not None and other_msg._banner._is_present_in_parent:
            if self._banner is None:
                self._banner = Banner.__new__(Banner)
                self._banner.reset()
                self._banner._listener = self._Modified
            self._banner.MergeFrom(other_msg._banner)

        self._Modified()

    cpdef int MergeFromString(self, data, size=None) except -1:
        """
        Merges serialized protocol buffer data into this message.

        Params:
            data (bytes): a string of binary data.
            size (int): optional - the length of the data string

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        buf = self._protobuf_deserialize(data, length, False)

        if buf != length:
            raise DecodeError("Truncated message: got %s expected %s" % (buf, size))

        self._Modified()

        return buf

    cpdef int ParseFromString(self, data, size=None, bint reset=True, bint cache=False) except -1:
        """
        Populate the message class from a string of protobuf encoded binary data.

        Params:
            data (bytes): a string of binary data
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
            cache (bool): optional - whether to cache serialized data

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        if reset:
            self.reset()

        buf = self._protobuf_deserialize(data, length, cache)

        if buf != length:
            raise DecodeError("Truncated message")

        self._Modified()

        if cache:
            self._cached_serialization = data

        return buf

    @classmethod
    def FromString(cls, s):
        message = cls()
        message.MergeFromString(s)
        return message

    cdef void _protobuf_serialize(self, bytearray buf, bint cache):
        # avatar
        cdef bytearray avatar_buf
        if self._avatar is not None and self._avatar._is_present_in_parent:
            set_varint64(10, buf)
            if self._avatar._cached_serialization is not None:
                set_varint64(len(self._avatar._cached_serialization), buf)
                buf += self._avatar._cached_serialization
            else:
                avatar_buf = bytearray()
                self._avatar._protobuf_serialize(avatar_buf, cache)
                set_varint64(len(avatar_buf), buf)
                buf += avatar_buf
                if cache:
                    self._avatar._cached_serialization = bytes(avatar_buf)
        # legend
        cdef bytearray legend_buf
        if self._legend is not None and self._legend._is_present_in_parent:
            set_varint64(18, buf)
            if self._legend._cached_serialization is not None:
                set_varint64(len(self._legend._cached_serialization), buf)
                buf += self._legend._cached_serialization
            else:
                legend_buf = bytearray()
                self._legend._protobuf_serialize(legend_buf, cache)
                set_varint64(len(legend_buf), buf)
                buf += legend_buf
                if cache:
                    self._legend._cached_serialization = bytes(legend_buf)
        # menu
        cdef bytearray menu_buf
        if self._menu is not None and self._menu._is_present_in_parent:
            set_varint64(26, buf)
            if self._menu._cached_serialization is not None:
                set_varint64(len(self._menu._cached_serialization), buf)
                buf += self._menu._cached_serialization
            else:
                menu_buf = bytearray()
                self._menu._protobuf_serialize(menu_buf, cache)
                set_varint64(len(menu_buf), buf)
                buf += menu_buf
                if cache:
                    self._menu._cached_serialization = bytes(menu_buf)
        # banner
        cdef bytearray banner_buf
        if self._banner is not None and self._banner._is_present_in_parent:
            set_varint64(34, buf)
            if self._banner._cached_serialization is not None:
                set_varint64(len(self._banner._cached_serialization), buf)
                buf += self._banner._cached_serialization
            else:
                banner_buf = bytearray()
                self._banner._protobuf_serialize(banner_buf, cache)
                set_varint64(len(banner_buf), buf)
                buf += banner_buf
                if cache:
                    self._banner._cached_serialization = bytes(banner_buf)

    cpdef void _Modified(self):
        self._is_present_in_parent = True
        self._listener()
        self._cached_serialization = None

    

    cpdef bytes SerializeToString(self, bint cache=False):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """

    

        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, cache)
        cdef bytes out = bytes(buf)

        if cache:
            self._cached_serialization = out

        return out

    cpdef bytes SerializePartialToString(self):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """
        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, False)
        return bytes(buf)

    def SetInParent(self):
        """
        Mark this an present in the parent.
        """
        self._Modified()

    def ParseFromJson(self, data, size=None, reset=True):
        """
        Populate the message class from a json string.

        Params:
            data (str): a json string
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
        """
        if size is None:
            size = len(data)
        d = json.loads(data[:size])
        self.ParseFromDict(d, reset)

    def SerializeToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializeToDict()
        return json.dumps(d, **kwargs)

    def SerializePartialToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializePartialToDict()
        return json.dumps(d, **kwargs)

    def ParseFromDict(self, d, reset=True):
        """
        Populate the message class from a Python dictionary.

        Params:
            d (dict): a Python dictionary representing the message
            reset (bool): optional - whether to reset to default values before serializing
        """
        if reset:
            self.reset()

        assert type(d) == dict
        try:
            self.avatar.ParseFromDict(d["avatar"])
        except KeyError:
            pass
        try:
            self.legend.ParseFromDict(d["legend"])
        except KeyError:
            pass
        try:
            self.menu.ParseFromDict(d["menu"])
        except KeyError:
            pass
        try:
            self.banner.ParseFromDict(d["banner"])
        except KeyError:
            pass

        self._Modified()

        return

    def SerializeToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        avatar_dict = self.avatar.SerializeToDict()
        if avatar_dict != {}:
            out["avatar"] = avatar_dict
        legend_dict = self.legend.SerializeToDict()
        if legend_dict != {}:
            out["legend"] = legend_dict
        menu_dict = self.menu.SerializeToDict()
        if menu_dict != {}:
            out["menu"] = menu_dict
        banner_dict = self.banner.SerializeToDict()
        if banner_dict != {}:
            out["banner"] = banner_dict

        return out

    def SerializePartialToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        avatar_dict = self.avatar.SerializePartialToDict()
        if avatar_dict != {}:
            out["avatar"] = avatar_dict
        legend_dict = self.legend.SerializePartialToDict()
        if legend_dict != {}:
            out["legend"] = legend_dict
        menu_dict = self.menu.SerializePartialToDict()
        if menu_dict != {}:
            out["menu"] = menu_dict
        banner_dict = self.banner.SerializePartialToDict()
        if banner_dict != {}:
            out["banner"] = banner_dict

        return out

    def Items(self):
        """
        Iterator over the field names and values of the message.

        Returns:
            iterator
        """
        yield 'avatar', self.avatar
        yield 'legend', self.legend
        yield 'menu', self.menu
        yield 'banner', self.banner

    def Fields(self):
        """
        Iterator over the field names of the message.

        Returns:
            iterator
        """
        yield 'avatar'
        yield 'legend'
        yield 'menu'
        yield 'banner'

    def Values(self):
        """
        Iterator over the values of the message.

        Returns:
            iterator
        """
        yield self.avatar
        yield self.legend
        yield self.menu
        yield self.banner

    

    def Setters(self):
        """
        Iterator over functions to set the fields in a message.

        Returns:
            iterator
        """
        def setter(value):
            self.avatar = value
        yield setter
        def setter(value):
            self.legend = value
        yield setter
        def setter(value):
            self.menu = value
        yield setter
        def setter(value):
            self.banner = value
        yield setter

    
