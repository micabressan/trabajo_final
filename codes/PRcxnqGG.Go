L0, B0, R0 := earth.Position(jde)
	L, B, R := p.Position(jde)
	sB0, cB0 := math.Sincos(B0)
	sL0, cL0 := math.Sincos(L0)
	sB, cB := math.Sincos(B)
	sL, cL := math.Sincos(L)
	x := R*cB*cL - R0*cB0*cL0
	y := R*cB*sL - R0*cB0*sL0
	z := R*sB - R0*sB0
	{
		Δ := math.Sqrt(x*x + y*y + z*z) // (33.4) p. 224
		τ := base.LightTime(Δ)
		// repeating with jde-τ
		L, B, R = p.Position(jde - τ)
		sB, cB = math.Sincos(B)
		sL, cL = math.Sincos(L)
		x = R*cB*cL - R0*cB0*cL0
		y = R*cB*sL - R0*cB0*sL0
		z = R*sB - R0*sB0
	}
	λ := math.Atan2(y, x)                // (33.1) p. 223
	β := math.Atan2(z, math.Hypot(x, y)) // (33.2) p. 223
	Δλ, Δβ := apparent.EclipticAberration(λ, β, jde)
	λ, β = pp.ToFK5(λ+Δλ, β+Δβ, jde)
	Δψ, Δε := nutation.Nutation(jde)
	λ += Δψ
	sε, cε := math.Sincos(nutation.MeanObliquity(jde) + Δε)
	return coord.EclToEq(λ, β, sε, cε)