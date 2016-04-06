				for (size_t w = 0; w < 16; w++) {
					mix1.words[w] = mix1.words[w] * 0x01000193 ^ dag_node->words[w];
				}