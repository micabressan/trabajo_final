/* after the generation step has finished we allocate our thread configuration (mainly the thread pool) */
for (i = 0; i < possible_thread_count; i++) {
	thread_pool.push_back(std::thread([&benchmark_vector](std::chrono::time_point<std::chrono::system_clock> &start, std::chrono::time_point<std::chrono::system_clock> &end){
	/* first phase: generating a random token to look out for */
	char first_phase_token = alphabet[rand() % alphabet.length()];
	/* the second phase looks out for two tokens simultaniosuly */
	char second_phase_token[2];
	for (auto i = 0; i < 2; i++) {
		generate_new_token:
			second_phase_token[i] = alphabet[rand() % alphabet.length()];
			if (i != 0)
				if (second_phase_token[i - 1] == second_phase_token[i])
					goto generate_new_token;
	}
	/* the third phase generates a random token string with random length, but not longer than 1/4 of the average length of the benchmark_vector */
	std::unique_ptr<std::vector<size_t>> line_length(new std::vector<size_t>);
	std::future<size_t> calculate_average_line_length = std::async(std::launch::async, [&](size_t vector_size) -> size_t {
		size_t sum;
		while (true) {
			if (line_length->size() == vector_size) {
				for (auto x = 0; x < vector_size; x++)
					sum += line_length->at(x);
				return (size_t)(sum / vector_size);
			}
		}
	}, benchmark_vector.size());
	for (auto it = benchmark_vector.begin(); it != benchmark_vector.end(); it++) {
		line_length->push_back(it->length());
	}
	}));
}