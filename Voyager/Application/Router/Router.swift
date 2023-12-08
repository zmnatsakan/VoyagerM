//
//  GameStateRoute.swift
//  Voyager
//
//  Created by admin on 23.11.2023.
//

import SwiftUI

protocol NavHost {}

struct RouteStack<V: NavHost> {
    var routes: [V] = []
    
    mutating func push(_ s: V) {
        self.routes.append(s)
    }
    
    mutating func pop() {
        _ = self.routes.popLast()
    }
    
    mutating func popToRoot() {
        self.routes.removeAll()
    }
    
    func top() -> V? {
        return self.routes.last
    }
}

class NavRouter<V: NavHost>: ObservableObject {
    @Published var route: V?
    
    var routeStack = RouteStack<V>() {
        didSet { self.route = routeStack.top() }
    }
    
    init(route: V?) {
        self.route = route
    }
    
    func push(route: V) {
        withAnimation(.bouncy(duration: 0.3)) {
            routeStack.push(route)
        }
        
    }
    
    func pop() {
        
        withAnimation(.bouncy(duration: 0.3)) {
            routeStack.pop()
        }
    }
    
    func popToRoot() {
        
        withAnimation(.linear(duration: 0.3)) {
            routeStack.popToRoot()
        }
    }
}



