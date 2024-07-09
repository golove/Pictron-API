//
//  Picture.swift
//  
//
//  Created by go love on 7/7/24.
//
import Vapor
import Fluent
import struct Foundation.UUID



final class Picture:Model,@unchecked Sendable {

	static let schema: String = "vipPicture"
	
	@ID(key: .id)
	var id:UUID?
	
	@Field(key: "created_at")
	var created_at:Date?

	@Field(key: "title")
	var title: String
	
	@Field(key: "url")
	var url:String
	
	@Field(key: "srcs")
	var srcs:[Src]
	
	@Field(key: "star")
	var star:Int
	
	@Field(key: "collect")
	var collect:Bool
	
	@Field(key: "download")
	var download:Bool
	
	@Field(key: "delete")
	var delete:Bool
	
	init() { }
	
	init(id:UUID? = nil,created_at:Date? = Date() ,title: String, url: String, star: Int, collect: Bool,delete:Bool,srcs:[Src],download:Bool) {
		self.id = id
		self.created_at = created_at
		self.title = title
		self.url = url
		self.srcs = srcs
		self.star = star
		self.collect = collect
		self.download = download
		self.delete = delete
	}
	
	func toDTO()->PictureDTO{
		.init(id:self.id,created_at: self.created_at,title: self.title ,url: self.url, srcs:self.srcs, star: self.star, collect: self.collect,download:self.download,delete:self.delete)
		
	}
	

	
	
}
