const menu = {
  _courses: {
    _appetizers:[],
    _mains: [],
    _desserts:[],
  },
  
  get appetizers(){},
  get mains(){},
  get desserts(){},
  
  set appetizers(appetizer){},
  set mains(main){},
  set desserts(dessert){},
  
  get courses(){
    return {appetizers: this._courses.appetizers, 
    mains: this._courses.mains, 
    desserts: this._courses.desserts}
  },
  
  addDishToCourse(courseName,dishName,dishPrice){
    const dish = {dishName: dishPrice};
    this._courses[courseName].push();
  },
  
  getRandomDishFromCourse(courseName){
    const dishes = this._courses[courseName];
    const randomIndex = Math.Floor(Math.random()*dishes.length);
    
    return dishes[randomIndex];
  },
  
  generateRandomMeal(){
    const appetizer = this.getRandomDishFromCourse('appetizers');
    const main = this.getRandomDishFromCourse('mains');
    const dessert = this.getRandomDishFromCourse('desserts');
    
    const totalPrice = appetizer.price + main.price + dessert.price;
    
    return `Your meal is ${appetizer.name}, ${main.name} & ${dessert.name}, The price is $${totalPrice}.`;
    
  },
  
};



menu.addDishToCourse('appetizers', 'Caesar Salad', 4.25);
menu.addDishToCourse('appetizers', 'Artichoke dip', 5.25);
menu.addDishToCourse('appetizers', 'Coconut Shrimps', 8.25);

menu.addDishToCourse('mains', 'blt', 6.25);
menu.addDishToCourse('mains', 'sandwich', 6.25);
menu.addDishToCourse('mains', 'soup', 6.25);

menu.addDishToCourse('desserts', 'icecream', 6.25);
menu.addDishToCourse('desserts', 'donut', 6.25);
menu.addDishToCourse('desserts', 'creme brule', 6.25);

let meal = menu.generateRandomMeal();
console.log(meal);