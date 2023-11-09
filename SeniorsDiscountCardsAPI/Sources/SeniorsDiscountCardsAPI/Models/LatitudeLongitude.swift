import Fluent
import Vapor

final class LatitudeLongitude : Fields {
    @Field(key: "latitude")
    var latitude: Double

    @Field(key: "longitude")
    var longitude: Double

    init() {}
}