	namespace implem {
		///----------------------------------------------------------------------
		///Equivalent to (parA + parB) % parDiv
		///----------------------------------------------------------------------
		inline CoordinateScalarType sum_mod (CoordinateScalarType parA, CoordinateScalarType parB, CoordinateScalarType parDiv) {
			//const auto sum = m_pos[index] + parValue;
			//const auto sz = m_size[index] + 1;
			//const auto remainder = sum - (sum / sz) * sz;

			//m_pos[index] = remainder;
			//parValue /= sz;

			const auto rounded_sum = sum_div(parA, parB, parDiv) * parDiv;
			return std::max(parA, parB) - rounded_sum + std::min(parA, parB);
		}

		///----------------------------------------------------------------------
		///Equivalent to (parA + parB) / parDiv
		///----------------------------------------------------------------------
		inline CoordinateScalarType sum_div (CoordinateScalarType parA, CoordinateScalarType parB, CoordinateScalarType parDiv) {
			DK_ASSERT(parA >= 0 and parB >= 0 and parDiv > 0);
			DK_ASSERT(std::numeric_limits<CoordinateScalarType>::max() - (parA % parDiv) >= (parB % parDiv));
			const auto x = ((parA % parDiv) + (parB % parDiv)) / parDiv;
			DK_ASSERT(std::numeric_limits<CoordinateScalarType>::max() - parA / parDiv >= parB / parDiv);
			DK_ASSERT(std::numeric_limits<CoordinateScalarType>::max() - parA / parDiv - parB / parDiv >= x);
			return parA / parDiv + parB / parDiv + x;
		}

		inline CoordinateScalarType sub_mod (CoordinateScalarType parA, CoordinateScalarType parB, CoordinateScalarType parDiv) {
			typedef std::make_unsigned<CoordinateScalarType>::type unsigned_coord;
			const unsigned_coord rounded_sum = static_cast<unsigned_coord>(sub_div(parA, parB, parDiv) * parDiv);
			const unsigned_coord ret = static_cast<unsigned_coord>(parA) - rounded_sum - static_cast<unsigned_coord>(parB);
			return static_cast<CoordinateScalarType>(ret);
		}

		inline CoordinateScalarType sub_div (CoordinateScalarType parA, CoordinateScalarType parB, CoordinateScalarType parDiv) {
			const auto x = ((parA % parDiv) + (parB % parDiv)) / parDiv;
			return parA / parDiv - parB / parDiv + x;
		}
	} //namespace implem







	template <uint32_t D>
	const TileCoords<D>& TileCoords<D>::operator-= (CoordinateScalarType parValue) {
		std::size_t index = 0;
		if (parValue > 0) {
			while (parValue) {
				const auto t = parValue % (m_size[index] + 1);
				DK_ASSERT(t >= 0);
				const CoordinateScalarType r = (t > m_pos[index] ? 1 : 0);
				m_pos[index] = (m_size[index] + 1) * r + m_pos[index] - t;
				parValue /= (m_size[index] + 1);
				parValue += r;

				++index;
			}
		}
		else if (parValue < 0) {
			while (parValue) {
				const auto new_pos = implem::sub_mod(m_pos[index], parValue, m_size[index] + 1);
				parValue = -implem::sub_div(m_pos[index], parValue, m_size[index] + 1);
				m_pos[index] = new_pos;

				++index;
			}
		}

		return *this;
	}

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