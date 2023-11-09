import Fluent
import Vapor

struct DiscountsController : RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let discounts = routes.grouped("discounts")
        discounts.group(":category") { discount in
            discount.get(use: getCategory)
            discount.group(":subcategory") { discount in
                discount.get(use: getSubcategory)
            }
        }
    }

    func getCategory(req: Request) async throws -> [Discount] {
        guard let category = req.parameters.get("category") else {
            throw Abort(.notFound)
        }

        if let city: String? = req.query["city"], let city, let state: String? = req.query["state"], let state {
            return try await Discount.query(on: req.db).group(.and) { group in
                group.filter(\.$category == category)
                    .filter(\.$business.$address.$city == city)
                    .filter(\.$business.$address.$state == state)
            }.all()
        } else {
            return try await Discount.query(on: req.db).group(.and) { group in
                group.filter(\.$category == category)
            }.all()
        }
    }

    func getSubcategory(req: Request) async throws -> [Discount] {
        guard let category = req.parameters.get("category"),
            let subcategory = req.parameters.get("subcategory") else {
            throw Abort(.notFound)
        }

        if let city: String? = req.query["city"], let city, let state: String? = req.query["state"], let state {
            return try await Discount.query(on: req.db).group(.and) { group in
                group.filter(\.$category == category)
                    .filter(\.$subcategory == subcategory)
                    .filter(\.$business.$address.$city == city)
                    .filter(\.$business.$address.$state == state)
            }.all()
        } else {
            return try await Discount.query(on: req.db).group(.and) { group in
            group.filter(\.$category == category)
                .filter(\.$subcategory == subcategory)
        }.all()
        }
    }
}