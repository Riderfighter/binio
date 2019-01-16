import binio

type
    Player = object
        PlayerID: uint32
        PlayerName: string
        PlayerLocation: PlayerPosition
    
    PlayerPosition = object
        X: float32
        Y: float32
        Z: float32

var newPlayer: Player
newPlayer.PlayerID = 1234
newPlayer.PlayerName = "Riderfighter"
newPlayer.PlayerLocation.X = 12.34
newPlayer.PlayerLocation.Y = 56.78
newPlayer.PlayerLocation.Z = 91.23


proc WriteToBytes*(p: var Player): Packet =
    result.WriteUInt32(newPlayer.PlayerID)
    result.WriteString(newPlayer.PlayerName)
    result.WriteFloat(newPlayer.PlayerLocation.X)
    result.WriteFloat(newPlayer.PlayerLocation.Y)
    result.WriteFloat(newPlayer.PlayerLocation.Z)

proc ReadPlayerPacket*(p: var Packet): Player =
    result.PlayerID = p.ReadUInt32()
    result.PlayerName = p.ReadString()
    result.PlayerLocation.X = p.ReadFloat()
    result.PlayerLocation.Y = p.ReadFloat()
    result.PlayerLocation.Z = p.ReadFloat()

var packed = newPlayer.WriteToBytes()

echo "Packed player data as hex: ", packed

var unpacked = packed.ReadPlayerPacket()

echo "Unpacked data as player type: ",unpacked

# at this point you can just send the packed data over a socket connection
#  e.g. net.Socket.send(packed)
