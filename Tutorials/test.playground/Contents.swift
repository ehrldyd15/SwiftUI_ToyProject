import UIKit

protocol Menu {
    func printCoffee()
    func printMeal()
}

class Eat: Menu {
    var coffee: String
    var meal: String
    
    init(coffee: String, meal: String) {
        self.coffee = coffee
        self.meal = meal
    }
    
    func printCoffee() {
        print(coffee)
    }
    
    func printMeal() {
        print(meal)
    }
}

struct Person {
    var todayEat: Menu
    
    func printCoffee() {
        todayEat.printCoffee()
    }
    
    func printMeal() {
        todayEat.printMeal()
    }
    
    mutating func changeMenu(menu: Menu) {
        self.todayEat = menu
    }
}

let menu = Eat(coffee: "아메리카노", meal: "피자")
let anotherMenu = Eat(coffee: "라떼", meal: "햄버거")

var suhshin = Person(todayEat: menu)

suhshin.printCoffee() // print 아메리카노
suhshin.changeMenu(menu: anotherMenu)
suhshin.printCoffee() // print 라떼
