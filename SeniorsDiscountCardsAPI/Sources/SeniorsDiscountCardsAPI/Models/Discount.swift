import Fluent
import Vapor

final class Discount : Content, Model {
    static let schema = "discounts"

    @ID(key: .id)
    var id: UUID?

    @Group(key: "business")
    var business: Business

    @Field(key: "category")
    var category: String

    @Field(key: "subcategory")
    var subcategory: String

    init() {}
}