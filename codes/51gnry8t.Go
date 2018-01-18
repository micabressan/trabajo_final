package parser

import (
    "regexp"
    "strconv"
    "bytes"
)

type Period struct {
    Year   int
    Month  int
    Day    int
    Hour   int
    Minute int
    Second int
}

func ParseWithRegexp(s string) Period {
    re := regexp.MustCompile(`P(([\d]+)Y)?(([\d]+)M)?(([\d]+)D)?T(([\d]+)H)?(([\d]+)M)?(([\d]+)S)?`)
    matches := re.FindAllStringSubmatch(s, -1)

    return Period{
        Year:   stringToInt(matches[0][2]),
        Month:  stringToInt(matches[0][4]),
        Day:    stringToInt(matches[0][6]),
        Hour:   stringToInt(matches[0][8]),
        Minute: stringToInt(matches[0][10]),
        Second: stringToInt(matches[0][12]),
    }
}

func ParseWithoutRegexp(s string) Period {
    p := Period{}

    var currentBuffer *bytes.Buffer

    isTime := false

    for _, c := range s {
        switch {
        case c == 'P':
            currentBuffer = bytes.NewBuffer(nil)

        case c == 'T':
            isTime = true
            currentBuffer = bytes.NewBuffer(nil)

        case c == 'Y':
            p.Year = stringToInt(currentBuffer.String())
            currentBuffer = bytes.NewBuffer(nil)

        case c == 'M' && isTime == false:
            p.Month = stringToInt(currentBuffer.String())
            currentBuffer = bytes.NewBuffer(nil)

        case c == 'D':
            p.Day = stringToInt(currentBuffer.String())
            currentBuffer = bytes.NewBuffer(nil)

        case c == 'H':
            p.Hour = stringToInt(currentBuffer.String())
            currentBuffer = bytes.NewBuffer(nil)

        case c == 'M' && isTime == true:
            p.Minute = stringToInt(currentBuffer.String())
            currentBuffer = bytes.NewBuffer(nil)

        case c == 'S':
            p.Second = stringToInt(currentBuffer.String())
            currentBuffer = bytes.NewBuffer(nil)

        default:
            currentBuffer.WriteRune(c)
        }

    }

    return p
}

func stringToInt(s string) int {
    if s == "" {
        return 0
    }
    i, _ := strconv.Atoi(s)
    return i
}