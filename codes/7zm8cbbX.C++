    // Navigation
    :x      x:
    ^x      goto x;
    §x      x()
    $x      ptr = data[x];

    // Logik
    [       while(true) {
    ]       if(!**ptr) break; }
    (       if(s0.pop() == s0.pop()) {
    )       }
    {       if(s0.pop() < s0.pop()) {
    }       }

    !       for(int i = 0; i < 2; ++i)

    // Mathematische Operationen
    >       ++ptr;
    <       --ptr;
    +       ++*ptr;
    -       --*ptr;

    // Stack
    ~       s0.push(*ptr);
    *       *ptr = s1.pop();

    // Grafik
    =       frame[s0.pop()][s0.pop()] = s0.pop();

    // I/O
    .       printChar(*ptr);
    ,       input. w/e
    &       s0.push(next = getKey.next);

    // Sonstiges
    #        sleep(s0.pop);