//
//  Cartoon.swift
//  CADisplayLink
//
//  Created by Falguni Viral Chauhan on 23/06/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import Foundation

struct Cartoon {
    let name: String
    let imageName: String
    let story: String
    
    static func getListOfCartoons() -> [Cartoon]{
        let cartoons = [
            Cartoon(name: "Turtle", imageName: "Turtle", story: "Turtles have been on the earth for more than 200 million years. They evolved before mammals, birds, crocodiles, snakes and even lizards."),
            Cartoon(name: "Cat", imageName: "Cat", story: "A cat can jump up to five times its own height in a single bound"),
            Cartoon(name: "Goldfish", imageName: "Goldfish", story: "Goldfish can actually see 4 colours, while humans only see 3 colours. Goldfish can see red, green and blue along with ultraviolet light, giving them polarized vision.")
        ]
        return cartoons
    }
    
}
