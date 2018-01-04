n = 0;
k = 0;
until n > 2 and n < 7
  puts "give a dimension number 2<n<7:"
  n = gets.chomp.to_i
end

vectorA = []
vectorB = []

for x in 0..n
  vectorA[x] = rand() % 10
  vectorB[x] = rand() % 10
end

def add(vecA, vecB, n)
  vecC = []
  for i in 0..n
    vecC[i] = vecA[i] + vecB[i]
  end
  return vecC
end

def dif(vecA, vecB, n)
  vecC = []
  for i in 0..n
    vecC[i] = vecA[i] - vecB[i]
  end
  return vecC
end

def prod(vector, k, n)
  for i in 0..n
    vecA[i] = vecA[i] *k
  end
end

def dot(vecA, vecB, n)
  result = 0
  for i in 0..n
    result += vecA[i] * vecB[i]
  end
  return result
end