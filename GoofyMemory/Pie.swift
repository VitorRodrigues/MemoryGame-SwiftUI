//
//  Pie.swift
//  GoofyMemory
//
//  Created by Vítor Nascimento on 31/01/2021.
//

import SwiftUI

struct Pie: Shape {

    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle(radians: newValue.first)
            endAngle = Angle(radians: newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()

        let center = CGPoint(x: rect.midX, y: rect.midY)
        p.move(to: center)
        p.addArc(center: center,
                 radius: rect.width/2,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: clockwise,
                 transform: .identity)

        p.closeSubpath()
        return p
    }
}

private struct PieView: View {
    var body: some View {
        Pie(startAngle: .degrees(0), endAngle: .degrees(270), clockwise: true)
    }
}

struct PieView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PieView()
                .padding()
        }
        .foregroundColor(.blue)
    }
}
