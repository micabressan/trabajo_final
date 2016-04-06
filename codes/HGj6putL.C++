		template <
			uint32_t D,
			short int S=
			(not std::numeric_limits<CoordinateScalarType>::is_signed or
				std::numeric_limits<CoordinateScalarType>::min() + std::numeric_limits<CoordinateScalarType>::max() == 0 ?
				0
			:
				(std::numeric_limits<CoordinateScalarType>::min() + std::numeric_limits<CoordinateScalarType>::max() < 0 ?
					1
				:
					-1
				)
			)
		>
		class MinEqToPlusEq;




		///----------------------------------------------------------------------
		///Specialization for |min| < max
		///----------------------------------------------------------------------
		template <uint32_t D>
		void MinEqToPlusEq<D, -1>::call (TileCoords<D>& parTC, CoordinateScalarType parValue) {
			if (parValue <= 0) {
				parTC.operator+=(-parValue);
			}
			else {
				constexpr auto diff = std::numeric_limits<CoordinateScalarType>::max() + std::numeric_limits<CoordinateScalarType>::min();
				static_assert(diff > 0, "|min| was expected to be < max");
			}
		}