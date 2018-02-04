template<class T> class test{
public:
	test(T var){
		cout << "var ist kein string" << endl;
	}
};

template<> class test<std::string>{
public:
	test(T var){
		cout << "var ist ein string" << endl;
	}
};