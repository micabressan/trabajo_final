def htmlEndTagByStartTag(startTag)
    x = 1
    endTag = "</"
    
    while (x < startTag.length)
          if startTag[x] == ' ' or startTag[x] == '>' then
             endTag = endTag + ">"
             return endTag
          end
              
          endTag = endTag + startTag[x]
              
          x = x + 1
    end
end