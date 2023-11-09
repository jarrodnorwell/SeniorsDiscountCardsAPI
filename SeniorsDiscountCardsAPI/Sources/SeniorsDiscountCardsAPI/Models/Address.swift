import Fluent
import Vapor

final class Address : Fields {
    @Field(key: "city")
    var city: String

    @Group(key: "latitudeLongitude")
    var latitudeLongitude: LatitudeLongitude

    @Field(key: "state")
    var state: String

    init() {}
}