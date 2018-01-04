# ZESTAW D

def index_of_equality(tab)
  index = -1
  for i in 0..tab.length-1
    leftsidesum = 0
    rightsidesum = 0
    
    for l in 0..i-1
      leftsidesum += tab[l]
    end
    
    for r in i+1..tab.length-1
      rightsidesum += tab[r]
    end
    
    if(leftsidesum == rightsidesum)
      return i
    end
  end
end


tab = [1,2,3,4,-1]
print index_of_equality(tab)