	template <uint32_t D>
	const TileCoords<D>& TileCoords<D>::operator+= (CoordinateScalarType parValue) {
		std::size_t index = 0;
		if (parValue > 0) {
			while (parValue) {
				//naïve implementation
				//parValue += m_pos[index];
				//m_pos[index] = parValue % (m_size[index] + 1);
				//parValue /= (m_size[index] + 1);

				//overflow-aware implementation
				const auto new_pos = implem::sum_mod(m_pos[index], parValue, m_size[index] + 1);
				parValue = implem::sum_div(m_pos[index], parValue, m_size[index] + 1);
				m_pos[index] = new_pos;

				++index;
			}
		}
		else if (parValue < 0) {
			while (parValue) {
				//const auto t = (-parValue) % (m_size[index] + 1);
				const auto t = -(parValue % (m_size[index] + 1));
				DK_ASSERT(t >= 0);
				const CoordinateScalarType r = (t > m_pos[index] ? 1 : 0);
				m_pos[index] = (m_size[index] + 1) * r + m_pos[index] - t;
				parValue /= (m_size[index] + 1);
				parValue -= r;

				++index;
			}
		}

		return *this;
	}