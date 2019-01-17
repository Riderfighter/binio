import struct
import strutils

type
    Packet* = object
        Index: int
        Data: string

proc `$`*(p: Packet): string =
    result = toHex(p.Data)

proc advance(p: var Packet, amount: int): int =
    p.Index += amount
    return p.Index

proc ReadBool*(p: var Packet): bool =
    let index = p.Index
    return struct.unpack(">?", p.Data[index..p.advance(1)-1])[0].getBool

proc WriteBool*(p: var Packet, boolean: bool) = 
    let byteData = struct.pack(">?", boolean)
    p.Data.add(byteData)

proc ReadFloat*(p: var Packet): float32 =
    let index = p.Index
    return struct.unpack(">f", p.Data[index..p.advance(4)-1])[0].getFloat

proc WriteFloat*(p: var Packet, f: float32) =
    let byteData = struct.pack(">f", f)
    p.Data.add(byteData)

proc ReadInt16*(p: var Packet): int16 =
    let index = p.Index
    return struct.unpack(">h", p.Data[index..p.advance(2)-1])[0].getShort

proc WriteInt16*(p: var Packet, i: int16) =
    let byteData = struct.pack(">h", i)
    p.Data.add(byteData)

proc ReadUInt16*(p: var Packet): uint16 =
    let index = p.Index
    return struct.unpack(">H", p.Data[index..p.advance(2)-1])[0].getUShort

proc WriteUInt16*(p: var Packet, i: uint16) =
    let byteData = struct.pack(">H", i)
    p.Data.add(byteData)

proc ReadInt32*(p: var Packet): int32 =
    let index = p.Index
    return struct.unpack(">i", p.Data[index..p.advance(4)-1])[0].getInt

proc WriteInt32*(p: var Packet, i: int32) =
    let byteData = struct.pack(">i", i)
    p.Data.add(byteData)

proc ReadUInt32*(p: var Packet): uint32 = 
    let index = p.Index
    return struct.unpack(">I", p.Data[index..p.advance(4)-1])[0].getUInt

proc WriteUInt32*(p: var Packet, number: uint32) =
    let byteData = struct.pack(">I", number)
    p.Data.add(byteData)

proc ReadInt64*(p: var Packet): int64 =
    let index = p.Index
    return struct.unpack(">q", p.Data[index..p.advance(8)-1])[0].getQuad

proc WriteInt64*(p: var Packet, i: int64) =
    let byteData = struct.pack(">q", i)
    p.Data.add(byteData)

proc ReadUInt64*(p: var Packet): uint64 =
    let index = p.Index
    return struct.unpack(">Q", p.Data[index..p.advance(8)-1])[0].getUQuad

proc WriteUInt64*(p: var Packet, i: uint64) =
    let byteData = struct.pack(">Q", i)
    p.Data.add(byteData)

proc ReadByte*(p: var Packet): char =
    let index = p.Index
    return struct.unpack(">b", p.Data[index..p.advance(1)-1])[0].getChar

proc WriteByte*(p: var Packet, i: char) =
    let byteData = struct.pack(">b", i)
    p.Data.add(byteData)

proc ReadString*(p: var Packet): string =
    var length = int(p.ReadUInt16())
    result = ""
    if length == 0:
        return result
    result.add(p.Data[p.Index..p.Index+length-1])
    discard(p.advance(length))

proc WriteString*(p: var Packet, s: string) =
    if s == "":
        p.WriteUInt16(uint16(0))
        return
    p.WriteUInt16(uint16(len(s)))
    for i in s:
        p.WriteByte(i)