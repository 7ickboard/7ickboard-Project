
import Foundation

struct KakaoLocation {
    enum CodingKeys: String, CodingKey {
        case document = "documents"
    }
    enum DocumentsInfoKeys: CodingKey {
        case address
    }
    enum AddressInfoKeys: CodingKey {
        case x
        case y
    }
    var longitude: String?
    var latitude: String?
}

extension KakaoLocation: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        var documentsContainer = try container.nestedUnkeyedContainer(forKey: .document)

        let documentContainer = try documentsContainer.nestedContainer(keyedBy: DocumentsInfoKeys.self)

        let addressContainer = try documentContainer.nestedContainer(keyedBy: AddressInfoKeys.self, forKey: .address)

        self.longitude = try addressContainer.decode(String.self, forKey: .x)
        self.latitude = try addressContainer.decode(String.self, forKey: .y)
    }
}
