#include <iostream>

class A {
public:
    std::string name;
    
    A& operator=(const A& a) { // "ekvivalentni" s A& operator=(const A&) = default;
        name = a.name;
        std::cout << "copying a" << std::endl;
        return *this;
    }
    
    A& operator=(A&& a) { // "ekvivalentni" s A& operator=(A&&) = default;
        name = std::move(a.name);
        std::cout << "stealing a" << std::endl;
        return *this;
    }
};

void move_const_ref(const A& a) {
    A b;
    b = std::move(a); // decltype(std::move(a)) je const A&&, coz se na A&& "nenabinduje" 
}

int main()
{
    A a;
    move_const_ref(a); // vypise "copying a"
    return 0;
}