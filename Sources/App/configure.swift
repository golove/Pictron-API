import NIOSSL
import Fluent
import FluentMongoDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

try app.databases.use(DatabaseConfigurationFactory.mongo(
        connectionString: Environment.get("DATABASE_URL") ?? "mongodb://mongodb:27017/pictron"
    ), as: .mongo)

    app.migrations.add(CreateTodo())
    app.migrations.add(CreatePicture())
    // Configure custom hostname.
    // register routes
    try routes(app)
}
