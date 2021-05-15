//
//  Restaurant.swift
//  frestaurant
//
//  Created by Christianto Budisaputra on 14/05/21.
//

import Foundation

// MARK: - RestaurantList
public struct RestaurantList: Codable {
    public let error: Bool
    public let message: String
    public let count: Int
    public let restaurants: [RestaurantBrief]

    public init(error: Bool, message: String, count: Int, restaurants: [RestaurantBrief]) {
        self.error = error
        self.message = message
        self.count = count
        self.restaurants = restaurants
    }
}

// MARK: - Restaurant
public struct RestaurantBrief: Codable {
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

// MARK: - RestaurantDetail
public struct RestaurantDetail: Codable {
    public let error: Bool
    public let message: String
    public let restaurant: Restaurant

    public init(error: Bool, message: String, restaurant: Restaurant) {
        self.error = error
        self.message = message
        self.restaurant = restaurant
    }
}

// MARK: - Restaurant
public struct Restaurant: Codable {
    public let id, name, restaurantDescription, city: String
    public let address, pictureID: String
    public let categories: [Category]
    public let menus: Menus
    public let rating: Double
    public let customerReviews: [CustomerReview]

    enum CodingKeys: String, CodingKey {
        case id, name
        case restaurantDescription = "description"
        case city, address
        case pictureID = "pictureId"
        case categories, menus, rating, customerReviews
    }

    public init(id: String, name: String, restaurantDescription: String, city: String, address: String, pictureID: String, categories: [Category], menus: Menus, rating: Double, customerReviews: [CustomerReview]) {
        self.id = id
        self.name = name
        self.restaurantDescription = restaurantDescription
        self.city = city
        self.address = address
        self.pictureID = pictureID
        self.categories = categories
        self.menus = menus
        self.rating = rating
        self.customerReviews = customerReviews
    }
}

// MARK: - Category
public struct Category: Codable {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}

// MARK: - CustomerReview
public struct CustomerReview: Codable {
    public let name, review, date: String

    public init(name: String, review: String, date: String) {
        self.name = name
        self.review = review
        self.date = date
    }
}

// MARK: - Menus
public struct Menus: Codable {
    public let foods, drinks: [Category]

    public init(foods: [Category], drinks: [Category]) {
        self.foods = foods
        self.drinks = drinks
    }
}
