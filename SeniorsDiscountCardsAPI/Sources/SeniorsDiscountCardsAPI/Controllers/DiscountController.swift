import Fluent
import Vapor

struct DiscountController : RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let discount = routes.grouped("discount")
        discount.post(use: create)
        discount.group(":id") { discount in
            discount.get(use: getId)
            discount.delete(use: delete)
        }
    }

    func create(req: Request) async throws -> Discount {
        let discount = try req.content.decode(Discount.self)
        try await discount.save(on: req.db)
        return discount
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let discount = try await Discount.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await discount.delete(on: req.db)
        return .noContent
    }

    fileprivate func getId(request: Request) async throws -> Discount {
        guard let discount = try await Discount.find(request.parameters.get("id"), on: request.db) else {
            throw Abort(.notFound)
        }

        return discount
    }
}
