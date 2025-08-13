
import Foundation

//struct GuestModel {
//    var firstName: String
//    var secondName: String
//    var emailAdress: String
//    
//    var checkInDate: Date
//    var checkOutDate: Date
//    var numberOfAdults: Int
//    var numberOFChildren: Int
//    
//    var wifi: Bool
//    var roomType: RoomType
//}

struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static var all: [RoomType] = [
        RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
        RoomType(id: 1, name: "One Queen", shortName: "1Q", price: 150),
        RoomType(id: 2, name: "Three King", shortName: "3K", price: 200),
    ]
    
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        lhs.id == rhs.id
    }
}
