
import Foundation
import CoreLocation

struct KickBoard {
    var id: UUID
    var name: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees

    var coordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(id: UUID = UUID(), name: String = "킥보드", latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension KickBoard {
    static var kickboards: [KickBoard] = []
}
