typedef union node {
	uint8_t bytes[NODE_WORDS * 4];
	uint32_t words[NODE_WORDS];
	uint64_t double_words[NODE_WORDS / 2];
} node;	

for (size_t w = 0; w < 16; w++) {
	mix1.words[w] = mix1.words[w] * 0x01000193 ^ dag_node->words[w];
}