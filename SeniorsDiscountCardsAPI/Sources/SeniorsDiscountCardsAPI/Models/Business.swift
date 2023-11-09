import Fluent
import Vapor

final class Business : Fields {
    @Group(key: "address")
    var address: Address

    @Field(key: "email")
    var email: String?

    @Field(key: "name")
    var name: String

    @Field(key: "phone")
    var phone: String?

    @Field(key: "website")
    var website: String?

    init() {}
}