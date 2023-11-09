import Fluent
import Vapor

struct DiscountController : RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let discount = routes.grouped("discount")
        discount.group(":id") { discount in
            discount.get(use: getIdentifier)
        }
        discount.post(use: post)
    }

    func getIdentifier(req: Request) async throws -> Discount {
        guard let discount = try await Discount.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        return discount
    }

    func post(req: Request) async throws -> Discount {
        let discount = try req.content.decode(Discount.self)
        try await discount.save(on: req.db)
        return discount
    }
}