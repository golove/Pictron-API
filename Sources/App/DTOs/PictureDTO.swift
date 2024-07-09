//
//  PictureDTO.swift
//  
//
//  Created by go love on 7/7/24.
//

import Fluent
import Vapor

struct PictureDTO: Content {
	var id:UUID?
	var created_at:Date?
	var title: String?
	var url:String?
	var srcs:[Src]?
	var star:Int?
	var collect:Bool?
	var download:Bool?
	var delete:Bool?
	
	
	
	func toModel() -> Picture {
		Picture(id: self.id,created_at:self.created_at ?? Date(), title: self.title ?? "i", url: self.url ?? "love", star: self.star ?? 0, collect: self.collect ?? false, delete: self.delete ?? false, srcs: self.srcs ?? [Src](),download:self.download ?? false)
	}
}
