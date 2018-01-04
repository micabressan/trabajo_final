// Defines a signature made of an abstracttype
// and a function using this type.
signature Factory {
	alias Type;
	Type create();
}

// Extends the Factory signature
signature RoomFactory : Factory {
	void setSize(vec2 size);
}

// A Test type, used as Factory.Type
struct Room {
	vec2 size;
}

// An aggregate compliant with the extended factory
struct MyRoomFactory {
	alias Type=Room*;

	vec2 size_;
	void setSize(vec2 size) { size_ = size; }
	Room* create() { return new Room(size_); }
}

void main() {
	MyRoomFactory factory = ...;
	setSize(factory);
}

void setSize(IFactory : MyRoomFactory)(scope ref IFactory factory) {
	factory.setSize(...);
}

void myFunc(IFactory : Factory)(scope ref IFactory factory) {
	IFactory.Type myRoom = factory.create();
	...
}