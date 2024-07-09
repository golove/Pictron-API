//
//  CreatePicture.swift
//  
//
//  Created by go love on 7/7/24.
//

import Fluent

struct CreatePicture: AsyncMigration {
	func prepare(on database: Database) async throws {
		try await database.schema("vipPicture")
			.id()
			.field("title", .string, .required)
			.field("url", .string, .required)
			.field("srcs", .array, .required)
			.field("star", .int, .required)
			.field("collect", .bool, .required)
			.field("download", .bool, .required)
			.field("delete", .bool, .required)
			.create()
	}

	func revert(on database: Database) async throws {
		try await database.schema("vipPicture").delete()
	}
}
