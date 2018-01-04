def quiz (questions, i = 0, score = 0)
 
    puts questions[i][0]
    input = gets.chomp.downcase
    
    
    if (i >= questions.length)
      puts "End of quiz, you scored " + score.to_s
      return
    end
    
    if (input == questions[i][1])
      puts "correct answer!"
      score = score + 1
    else
      puts "wrong answer!"
    end
    
  quiz questions i+1 score
end