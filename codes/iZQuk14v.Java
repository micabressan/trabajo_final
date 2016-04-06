
    private double computeValue()
    {
        double d0 = this.getBaseValue(); // the base value of the entity
        AttributeModifier attributemodifier;

        for (Iterator iterator = this.func_180375_b(0).iterator(); iterator.hasNext(); d0 += attributemodifier.getAmount()) // get other modifiers, if any
        {
            attributemodifier = (AttributeModifier)iterator.next(); // select the modifier if found
        }

        double d1 = d0;
        Iterator iterator1;
        AttributeModifier attributemodifier1;
	// maybe if the names werent obfuscated, this made more sense...
        for (iterator1 = this.func_180375_b(1).iterator(); iterator1.hasNext(); d1 += d0 * attributemodifier1.getAmount())
        {
            attributemodifier1 = (AttributeModifier)iterator1.next();
        }
	// again gibberish, this could've been added to the previous for loop...
        for (iterator1 = this.func_180375_b(2).iterator(); iterator1.hasNext(); d1 *= 1.0D + attributemodifier1.getAmount())
        {
            attributemodifier1 = (AttributeModifier)iterator1.next();
        }

        return this.genericAttribute.clampValue(d1); // clamp the random outputted value, using MathHelper#clamp_double
    }

    // in MathHelper:
    public static double clamp_double(double val, double min, double max)
    {
        return val < min ? min : (val > max ? max : val);
    }