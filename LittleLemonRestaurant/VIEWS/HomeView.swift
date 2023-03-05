//
//  HomeView.swift
//  LittleLemonRestaurant
//
//  Created by Jorge Ivan Herrera Camara on 05/03/23.
//

import SwiftUI

let lemonColor = Color(red: 242/255, green: 197/255, blue: 50/255)
let greenColor = Color(red: 63/255, green: 84/255, blue: 77/255)
let whiteColor = Color(red: 255/255, green: 255/255, blue: 255/255)
let gray30Color = Color.gray.opacity(0.3)
let gray70Color = Color.gray.opacity(0.7)

enum Categories: String {
    case starters
    case mains
    case desserts
    case drinks
}

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var menuRepository = DishesModel()
    @State var searchText: String = ""
    @State var selectedCategory: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                heroView
                menuBreakdown
                //Food menu list
                FetchedObjects(
                    predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        List(dishes, id: \.self) { dish in
                            VStack {
                                DishView(dish)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
            }
            .navigationBarColor(.white)
                        .navigationBarHidden(false)
        .navigationBarTitle("Home", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 0.0) {
                        Image("lemon")
                            .resizable()
                            .scaledToFit()
                            .frame(width:34.0, height:34.0)
                            .padding(.bottom, 4.0)
                        Text("LITTLE LEMON")
                            .font(.system(size: 12.0))
                            .fontWeight(.semibold)
                            .foregroundColor(greenColor)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink(destination: ProfileView()) {
                            Image("profilePicture")
                                .resizable()
                                .scaledToFit()
                                .frame(width:36.0, height:36.0)
                                .cornerRadius(18.0)
                                .padding(.bottom, 8.0)
                        }
                    }
                }
            }
            .task {
                await menuRepository.reload(viewContext)
            }
        }
    }
    
    private var heroView: some View {
        VStack(alignment:.leading) {
            Text("Little Lemon")
                .font(.system(size: 44.0))
                .bold()
                .foregroundColor(Color(red: 242/255, green: 197/255, blue: 50/255))
            Text("Chicago")
                .font(.system(size: 26.0))
                .fontWeight(.semibold)
                .foregroundColor(.white)
            HStack {
                Text("We are a family owned\nMediterranean restaurant,\nfocused on traditional\nrecipes served with a\nmodern twist.")
                    .font(.system(size: 16.0))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Image("heroMainDish")
                    .resizable()
                    .scaledToFit()
                    .frame(width:150.0, height:150.0)
                    .cornerRadius(10.0)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("What's on your mind ?", text: $searchText)
                    .foregroundColor(.primary)
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(6.0)
        }
        .padding()
        .background(greenColor)
    }
    
    private var menuBreakdown: some View {
        VStack(alignment:.leading) {
            Text("ORDER FOR DELIVERY!")
                .fontWeight(.semibold)
                .padding(.leading, 16.0)
                .padding(.top, 12.0)
            HStack {
                Text("Starters")
                    .font(.system(size: 14.0))
                    .fontWeight(.semibold)
                    .padding(8.0)
                    .background(selectedCategory == Categories.starters.rawValue ? lemonColor : gray30Color)
                    .foregroundColor(selectedCategory == Categories.starters.rawValue ? .white : greenColor)
                    .cornerRadius(14.0)
                    .onTapGesture {
                        selectedCategory = selectedCategory == Categories.starters.rawValue ? "": Categories.starters.rawValue
                    }
                Spacer()
                Text("Mains")
                    .font(.system(size: 14.0))
                    .fontWeight(.semibold)
                    .padding(8.0)
                    .background(selectedCategory == Categories.mains.rawValue ? lemonColor : gray30Color)
                    .foregroundColor(selectedCategory == Categories.mains.rawValue ? .white : greenColor)
                    .cornerRadius(14.0)
                    .onTapGesture {
                        selectedCategory = selectedCategory == Categories.mains.rawValue ? "": Categories.mains.rawValue
                    }
                Spacer()
                Text("Desserts")
                    .font(.system(size: 14.0))
                    .fontWeight(.semibold)
                    .padding(8.0)
                    .background(selectedCategory == Categories.desserts.rawValue  ? lemonColor : gray30Color)
                    .foregroundColor(selectedCategory == Categories.desserts.rawValue ? .white : greenColor)
                    .cornerRadius(14.0)
                    .onTapGesture {
                        selectedCategory = selectedCategory == Categories.desserts.rawValue ? "": Categories.desserts.rawValue
                    }
                Spacer()
                Text("Drinks")
                    .font(.system(size: 14.0))
                    .fontWeight(.semibold)
                    .padding(8.0)
                    .background(selectedCategory == Categories.drinks.rawValue ? lemonColor : gray30Color)
                    .foregroundColor(selectedCategory == Categories.drinks.rawValue ? .white : greenColor)
                    .cornerRadius(14.0)
                    .onTapGesture {
                        selectedCategory = selectedCategory == Categories.drinks.rawValue ? "": Categories.drinks.rawValue
                    }
            }
            .padding([.leading, .trailing, .bottom], 16.0)
        }
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            if selectedCategory.count > 0 { return NSPredicate(format: "category CONTAINS[cd] %@", selectedCategory)}
        } else {
            if selectedCategory.isEmpty { return NSPredicate(format: "name CONTAINS[cd] %@", searchText) }
            return NSPredicate(format: "name CONTAINS[cd] %@ AND category CONTAINS[cd] %@", searchText, selectedCategory)
        }
        return NSPredicate(value: true)
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        [
            NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare)),
        ]
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension View {
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}
