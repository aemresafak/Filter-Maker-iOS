//
//  Triangle.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 15.09.2022.
//

import SwiftUI

struct Triangle: View {
    
    let inRectangle: CGRect
    
    var body: some View {
        createTriangle(in: inRectangle)
            .frame(width: inRectangle.width, height: inRectangle.height)
    }
    
    func createTriangle(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
     }
}

struct Triangle_Previews: PreviewProvider {
    static var previews: some View {
        Triangle(inRectangle: CGRect(x: 0, y: 0, width: 15, height: 10))
            .foregroundColor(.red)
    }
}
