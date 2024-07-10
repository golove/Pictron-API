//
//  PictureController.swift
//  
//
//  Created by go love on 7/7/24.
//

import Vapor
import Fluent

struct PictureController:RouteCollection{
	func boot(routes: any Vapor.RoutesBuilder) throws {
		let picture = routes.grouped("vipPicture")
		picture.get(use: self.index)
		picture.post(use: self.create)
		picture.group(":pictureID") { pic in
			pic.delete(use: self.delete)
			pic.put(use: self.update)
		}
		
	}
	
	@Sendable
	func index(req:Request)async throws->[PictureDTO]{
		try await Picture.query(on: req.db).all().map { $0.toDTO() }
	}
	
	@Sendable
	func create(req: Request) async throws -> PictureDTO {
		let picture = try req.content.decode(PictureDTO.self).toModel()

		if let pic = try await Picture.find(picture.id, on: req.db){
			print("already exit")
			return pic.toDTO()
		} else {
			try await picture.save(on: req.db)
			return picture.toDTO()
		}

		
	}
	
	@Sendable
	func delete(req: Request) async throws -> HTTPStatus {
		guard let picture = try await Picture.find(req.parameters.get("pictureID"), on: req.db) else {
			throw Abort(.notFound)
		}

		try await picture.delete(on: req.db)
		return .noContent
	}
	
	@Sendable
		func update(req: Request) async throws -> PictureDTO {
			let updatedPictureDTO = try req.content.decode(PictureDTO.self)
			print("Updated Picture DTO: \(updatedPictureDTO)")
		
			guard let picture = try await Picture.find(req.parameters.get("pictureID"), on: req.db) else {
				print("Picture with ID \(String(describing: req.parameters.get("pictureID"))) not found.")
				throw Abort(.notFound)
			}
			
			print("Picture before update: \(picture)")
//			picture.star = updatedPictureDTO.star ?? 0
			
			if let star = updatedPictureDTO.star{
				picture.star = star
			}
			
			if let delete = updatedPictureDTO.delete{
				picture.delete = delete
			}
			
			if let collect = updatedPictureDTO.collect{
				picture.collect = collect
			}
			
			if let download = updatedPictureDTO.download{
				picture.download = download
			}
			
//			picture.delete = updatedPictureDTO.delete ?? false
//			picture.collect = updatedPictureDTO.collect ?? false
//			picture.download = updatedPictureDTO.download ?? false
			try await picture.save(on: req.db)
			print("Picture after update: \(picture)")
			
			return picture.toDTO()
		}
}

