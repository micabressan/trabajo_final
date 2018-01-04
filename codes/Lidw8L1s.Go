package main

import (
	"fmt"
	"sort"
)

const inf = 999999999
const firstPoly = 6
const secondPoly = 5

func main() {
	constraint := 3
	poly := []int{firstPoly, secondPoly}
	bits := []byte{1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1}
	viterbi := NewViterbiDecoder(constraint, poly)
	fmt.Printf("+%v\n", viterbi.Decode(bits))
}

type Viterbi struct {
	nu       uint
	poly     []int
	polySize int
}

func NewViterbiDecoder(constraint int, poly []int) *Viterbi {
	return &Viterbi{
		nu:       uint(constraint),
		poly:     poly,
		polySize: len(poly),
	}
}

func (v *Viterbi) Decode(bits []byte) []byte {
	trellis := InitTrellis(0)
	pathMetrics := NewPathMetrics(1<<(v.nu-1), int(v.nu))

	curBits := make([]byte, 2)

	for i := 0; i < len(bits); i += v.polySize {
		curBits[0], curBits[1] = bits[i], bits[i+1]
		pathMetrics.Update(curBits, trellis)
	}

	decoded := make([]byte, 0)
	state := pathMetrics.Min()
	fmt.Printf("min state: %v\n", state)
	fmt.Printf("pathMetrics: %v\n", pathMetrics.paths)

	for i := trellis.Size() - 1; i >= 0; i-- {
		var sym byte // init with 0x0
		if (state >> (v.nu - 2)) != 0 {
			sym = 0x1
		}
		decoded = append(decoded, sym)
		state = trellis.Val(i, state)
	}
	Reverse(&decoded)
	return decoded[:len(decoded)-int(v.nu)+1]
}

func HammingDist(a, b []byte) int {
	if len(a) != len(b) {
		panic("slices are not equal to found their HammingDist")
	}

	d := 0
	for i := 0; i < len(a); i++ {
		if a[i] != b[i] {
			d++
		}
	}

	return d
}

func Reverse(b *[]byte) {
	if len(*b) == 0 {
		return
	}
	j := 0
	for i := len(*b) - 1; i != j; i-- {
		(*b)[i], (*b)[j] = (*b)[j], (*b)[j]
		j++
	}
}

func DistToZero(n int) int {
	n = n - ((n >> 1) & 0x55555555)
	n = (n & 0x33333333) + ((n >> 2) & 0x33333333)
	n = (n + (n >> 4)) & 0x0f0f0f0f
	n = n + (n >> 8)
	n = n + (n >> 16)
	return n & 0x3f
}

type Pair struct {
	k int
	v int
}

type Trellis struct {
	t [][]int
}

func (t *Trellis) Size() int {
	return len(t.t)
}

func InitTrellis(size int) *Trellis {
	return &Trellis{
		t: make([][]int, size),
	}
}

func (t *Trellis) AppendColumn(col []int) {
	t.t = append(t.t, col)
}

func (t *Trellis) Val(i, j int) int {
	if i < 0 || i >= len(t.t) {
		panic("Out of range")
	}
	if j < 0 || j >= len(t.t[0]) {
		panic("Out of range")
	}
	return t.t[i][j]
}

type PathMetrics struct {
	paths   []int
	strange int
}

//  Вычисляем занчение на ребре
func BranchMetric(curBits []byte, fromState, toState int) int {
	if len(curBits) != 2 {
		panic("length curBits should be eq 2")
	}
	//fmt.Printf("from: %d to: %d\n", fromState, toState)
	toState <<= 1
	lastBit := fromState%2
	newState := toState | lastBit

	firstByteOfWeight := DistToZero(firstPoly&newState) % 2
	secondByteOfWeight := DistToZero(secondPoly&newState) % 2

	out := []byte{byte(secondByteOfWeight), byte(firstByteOfWeight)}
	return HammingDist(curBits, out)
}

// Инициализируем все пути кроме нулевого бесконечностью
func NewPathMetrics(size int, strange int) *PathMetrics {
	p := &PathMetrics{
		paths:   make([]int, size),
		strange: strange,
	}
	for i := 1; i < len(p.paths); i++ {
		p.paths[i] = inf
	}
	return p
}

func (p *PathMetrics) EvaluateNext(curBits []byte, state int) Pair {
	s := (state & ((1 << uint(p.strange-2)) - 1)) << 1
	s1 := s | 0
	s2 := s | 1

	// ищем наиболее оптимальную метрику пути
	pm1 := p.paths[s1]
	if pm1 < inf {
		pm1 += BranchMetric(curBits, s1, state)
	}
	pm2 := p.paths[s2]
	if pm2 < inf {
		pm2 += BranchMetric(curBits, s2, state)
	}

	if pm1 <= pm2 {
		return Pair{pm1, s1}
	}

	return Pair{pm2, s2}
}

func (p *PathMetrics) Update(cur []byte, t *Trellis) {
	// Создаем новые элементы (новый ярус) решетки
	newCol := make([]int, 1<<uint(p.strange-1))
	newMetrics := make([]int, p.Len())
	for i := range newMetrics {
		p := p.EvaluateNext(cur, i)
		newMetrics[i], newCol[i] = p.k, p.v
	}
	p.paths = newMetrics
	t.AppendColumn(newCol)
}

func (p *PathMetrics) Min() int {
	sort.Sort(p)
	return p.paths[0]
}

// Sort interface implementation
func (p *PathMetrics) Less(i, j int) bool {
	if p.paths[i] < p.paths[j] {
		return true
	}
	return false
}
func (p *PathMetrics) Swap(i, j int) { p.paths[i], p.paths[j] = p.paths[j], p.paths[i] }
func (p *PathMetrics) Len() int      { return len(p.paths) }