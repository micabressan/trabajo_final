#include "AdventOfCode2k17.h"
#include <vector>
#include <iterator>
#include <numeric>
#include <algorithm>
#include <sstream>
#include <string>
#include <map>
#include <complex>

struct dir {
	int x, y, dx, dy;	
};

const dir & next(const dir & inp) {
	const bool rot = inp.x == inp.y || (inp.x < 0 && inp.x == -inp.y) || (inp.x > 0 && inp.x == 1 - inp.y);
	const int dx = rot ? -inp.dy : inp.dx;
	const int dy = rot ? inp.dx : inp.dy;
	return dir{ inp.x + dx,inp.y + dy, dx, dy };
}

template<>
void solve<Day3>(std::istream & is, std::ostream & os, bool part2) {
	int num = 0, dist; is >> num;
	if (!part2) {
		for (int i = 1; i < num; ++i) {
			int side = (2 * i + 1);
			int sq = side * side;
			if (sq > num) {
				int corr = (2 * i - 1)*(2 * i - 1);
				dist = i + abs(((num - corr) % (2 * i)) - i);
				break;
			}
		}
	}
	else {
		dir node{ 0,0,0,-1 };
		std::map<std::pair<int,int>, int> spiral;
		spiral[std::make_pair(node.x, node.y)] = 1;
		int sum = 0;		
		while (sum < num) {
			node = next(node);
			sum = 0;
			for (int dx = -1; dx < 2; ++dx) {
				for (int dy = -1; dy < 2; ++dy) {
					auto idx = std::make_pair(node.x + dx, node.y + dy);
					if (spiral.count(idx)) {						
						sum += spiral[idx];
					}
				}
			}
			spiral[std::make_pair(node.x, node.y)] = sum;
		}
		dist = sum;
	}
	os << "part" << (part2 ? "2" : "1") << " =" << dist << " ";	
}