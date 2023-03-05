//
//  DishView.swift
//  LittleLemonRestaurant
//
//  Created by Jorge Ivan Herrera Camara on 05/03/23.
//

import SwiftUI

struct DishView: View {
    @ObservedObject private var dish: Dish
    
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(dish.name ?? "N/A")
                .fontWeight(.semibold)
            HStack(alignment: .top)  {
                VStack(alignment: .leading) {
                    Text(dish.dishDescription)
                        .font(.system(size: 14.0))
                        .fontWeight(.thin)
                        .lineLimit(2)
                    Text(dish.formatPrice())
                        .font(.system(size: 14.0))
                        .fontWeight(.regular)
                        .padding(.vertical, 2.0)
                }
                Spacer()
                AsyncImage(
                    url: URL(string: dish.imageURL)!,
                    content: { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 80.0)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
            }
        }
    }
}

struct DisplayDish_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    
    let dish = Dish(context: context)
    
    static var previews: some View {
        DishView(oneDish())
    }
    
    static func oneDish() -> Dish {
        let dish = Dish(context: context)
        dish.name = "Hummus"
        dish.price = 10
        return dish
    }
}

