//
//  Test.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 25.1.22..
//

import SwiftUI

struct TestDrag: View {
    @State var isDragging = false

    var drag: some Gesture {
        DragGesture()
            .onChanged { _ in self.isDragging = true }
            .onEnded { _ in self.isDragging = false }
    }

    var body: some View {
        Circle()
            .fill(self.isDragging ? Color.red : Color.blue)
            .frame(width: 100, height: 100, alignment: .center)
            .gesture(
                DragGesture()
                    .onEnded{ _ in
                        print("Drag na krug")
                    }
            )
    }
}

struct TestDrag_Previews: PreviewProvider {
    static var previews: some View {
        TestDrag()
    }
}
