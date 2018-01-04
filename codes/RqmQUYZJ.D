class A {}
class B : A {}

void serializer(T)(T data);

void main() {
	A foo = new B;
	
	serializer(foo);
}