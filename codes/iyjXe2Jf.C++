#include <iostream>
#include <thread>

//#include <atomic>
//std::atomic<int> liczba(0);
volatile int liczba = 0;

void petla()
{
	for (int i = 0; i < 5000000; ++i)
		liczba++;
}

int main() {
	std::thread watek1(petla);
	std::thread watek2(petla);

	watek1.join();
	watek2.join();

	std::cout << "Liczba powinna wynosic 10000000.\n";
	std::cout << "Liczba wynosi: " << liczba << "\n";
}