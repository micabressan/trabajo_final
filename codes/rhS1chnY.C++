class B : public A; // forward declaration
class C : public D; 


class A {
	virtual void do(C c) { cout << "Hier botst A met C" }
	virtual void do(D d) { cout << "Hier botst A met D" }
}

class B : public A {
	virtual void do(C c) { cout << "Hier botst B met C"; }
	virtual void do(D d) { cout << "Hier botst B met D"; }
}

void main() {

	std::vector<A*> as{ new A(), new B() };
	std::vector<C*> cs{ new C(), new D() };
	
	for(auto& a : as)
		for(aut& c : cs)
			a->do(c)

	// A.do(D) en B.do(D) worden nu nooit aangeroepen

}