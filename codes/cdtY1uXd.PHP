    public function part2(): string
    {
        list($moveTransform, $partnerTransform) = $this->learnDance(explode(',', $this->inputReader->readLine()));
        $initialState = implode(',', $this->programs);
        // Find cycle size i.e., how many iterations before we encounter the initial state again
        $moveCycleSize = 0;
        do {
            $this->applyMoveTransform($moveTransform);
            $moveCycleSize++;
        }
        while (implode(',', $this->programs) !== $initialState);

        $partnerCycleSize = 0;
        do {
            $this->applyRenameTransform($partnerTransform);
            $partnerCycleSize++;
        }
        while (implode(',', $this->programs) !== $initialState);

        // Now apply just enough iterations for the remainder of the input after removing the cycle size
        for ($i = 0; $i < 1e9 % $moveCycleSize; $i++) {
            $this->applyMoveTransform($moveTransform);
        }
        for ($i = 0; $i < 1e9 % $partnerCycleSize; $i++) {
            $this->applyRenameTransform($partnerTransform);
        }
        return implode('', $this->programs);
    }