//
//  Constants.swift
//  frestaurant
//
//  Created by Christianto Budisaputra on 14/05/21.
//

import Foundation

extension URL {
  static let restaurantList = "https://restaurant-api.dicoding.dev/list"
  static let restaurantImage = "https://restaurant-api.dicoding.dev/images/small/"
  static let restaurantDetail = "https://restaurant-api.dicoding.dev/detail/"
}

// MARK: - RestaurantList
public struct RestaurantList: Codable {
    public let error: Bool
    public let message: String
    public let count: Int
    public let restaurants: [Restaurant]

    public init(error: Bool, message: String, count: Int, restaurants: [Restaurant]) {
        self.error = error
        self.message = message
        self.count = count
        self.restaurants = restaurants
    }
}

// MARK: - Restaurant
public struct Restaurant: Codable {
    public let id, name, restaurantDescription, pictureID: String
    public let city: String
    public let rating: Double

    enum CodingKeys: String, CodingKey {
        case id, name
        case restaurantDescription = "description"
        case pictureID = "pictureId"
        case city, rating
    }

    public init(id: String, name: String, restaurantDescription: String, pictureID: String, city: String, rating: Double) {
        self.id = id
        self.name = name
        self.restaurantDescription = restaurantDescription
        self.pictureID = pictureID
        self.city = city
        self.rating = rating
    }
}

