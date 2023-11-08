import Fluent
import Vapor

struct DiscountsController : RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let discounts = routes.grouped("discounts")
        discounts.get(use: index)
        discounts.group(":category") { discount in
            discount.get(use: getCategory)
            discount.group(":subcategory") { discount in
                discount.get(use: getSubcategory)
            }
        }
    }

    func index(req: Request) async throws -> [Discount] {
        try await Discount.query(on: req.db).all()
    }

    fileprivate func getCategory(request: Request) async throws -> [Discount] {
        guard let category = request.parameters.get("category") else {
            throw Abort(.notFound)
        }

        guard let city: String? = request.query["city"], let city, let state: String? = request.query["state"], let state else {
            throw Abort(.notFound)
        }

        return try await Discount.query(on: request.db).group(.and) { group in
            group.filter(\.$category == category)
                .filter(\.$business.$address.$city == city)
                .filter(\.$business.$address.$state == state)
        }.all()
    }

    fileprivate func getSubcategory(request: Request) async throws -> [Discount] {
        guard let category = request.parameters.get("category"), let subcategory = request.parameters.get("subcategory") else {
            throw Abort(.notFound)
        }

        guard let city: String? = request.query["city"], let city, let state: String? = request.query["state"], let state else {
            throw Abort(.notFound)
        }

        return try await Discount.query(on: request.db).group(.and) { group in
            group.filter(\.$category == category)
                .filter(\.$subcategory == subcategory)
                .filter(\.$business.$address.$city == city)
                .filter(\.$business.$address.$state == state)
        }.all()
    }
}
