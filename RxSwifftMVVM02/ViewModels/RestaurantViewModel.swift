//
//  RestaurantViewModel.swift
//  RxSwiftMVVM
//
//  Created by MacOS on 06/09/2021.
//

import Foundation

struct RestaurantViewModel {
    
    private let restaurant: Restaurant
    
    var displayText: String {
        return restaurant.name + " - " + restaurant.place
    }
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
}
