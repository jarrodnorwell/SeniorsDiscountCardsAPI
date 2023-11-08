import Fluent
import Vapor

final class LatitudeLongitude : Fields {
        @Field(key: "latitude")
        var latitude: Double
        
        @Field(key: "longitude")
        var longitude: Double

        init() {}
    }

final class Address : Fields {
    @Field(key: "city")
    var city: String

    @Group(key: "latitudeLongitude")
    var latitudeLongitude: LatitudeLongitude
    
    @Field(key: "state")
    var state: String

    init() {}
}

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

final class Discount : Model, Content {
    static let schema = "discounts"

    @ID(key: .id)
    var id: UUID?

    @Group(key: "business")
    var business: Business

    @Field(key: "category")
    var category: String

    @Field(key: "description")
    var description: String

    @Field(key: "discount")
    var discount: Double

    @Field(key: "endDate")
    var endDate: String

    @Field(key: "startDate")
    var startDate: String

    @Field(key: "subcategory")
    var subcategory: String

    @Field(key: "title")
    var title: String

    init() {}

    init(id: UUID? = nil, business: Business, category: String, description: String, discount: Double, endDate: String, startDate: String, subcategory: String, title: String) {
        self.id = id
        self.business = business
        self.category = category
        self.description = description
        self.discount = discount
        self.endDate = endDate
        self.startDate = startDate
        self.subcategory = subcategory
        self.title = title
    }
}