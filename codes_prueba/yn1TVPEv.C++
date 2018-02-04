/**
 * Implements the Singleton Design pattern.
 * Use the Meyer's Singleton that is guaranteed to be thread-safe in c++11
 * It use Macro instead a template model allowing to write the class definition inside source file.
 * That ensures all compilation modules share the same instance
 *
 * The SINGLETON macro declare the singleton related members (header file side)
 */
#define SINGLETON(className) \
public: \
    static className & instance(); \
private: \
    className(); \
    className(const className & other) = delete; \
    className & operator= (const className &) = delete;

/**
 * The SINGLETON_IMPLEMENTATION macro define the singleton related members (source file side)
 */
#define SINGLETON_IMPLEMENTATION(className) \
    className & className::instance() \
    { \
        static className _instance; \
        return _instance; \
    } \

//Foo.h

Class Foo {
	SINGLETON(Foo)
};

//Foo.cpp
SINGLETON_IMPLEMENTATION(Foo)

Foo::Foo() {
 //...
}