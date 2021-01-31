//
//  Grid.swift
//  GoofyMemory
//
//  Created by Vítor Nascimento on 30/12/2020.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {

    var items: [Item]
    var itemView: (Item) -> ItemView


    var body: some View {
        GeometryReader { geometry in
            createBody(in: GridLayout(itemCount: items.count, in: geometry.size))
        }
    }

    func createBody(in layout: GridLayout) -> some View {
        ForEach(items) { item in
            itemBody(for: item, in: layout)
        }
    }

    func itemBody(for item: Item, in layout: GridLayout) -> some View {
        let itemIndex = indexOf(item)
        return itemView(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: itemIndex))
    }

    func indexOf(_ item: Item) -> Int {
        return items.firstIndex(matching: item) ?? 0
    }
}
