custom_require.call(%w[common])

loop do
  case DRC.bput('forage dirt', 'You manage', 'You wander')
	when 'You manage'
    result = DRC.bput('put my dirt in my vial', 'You briefly twist', 'any more room')
    break if result =~ /any more room/
  end
end

2.times { 
  case DRC.bput('drop my dirt', 'You drop', 'What were')
  when 'What were'
    break
  end    
}