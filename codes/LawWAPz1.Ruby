##
# This list of all comments on our post
##
raw_comments = [
  'You are stupid!',
  'Great post!',
  'I love your video',
  'I hate everything. Especially your stupid post.',
  'I just came by to leave this comment totally void of any value. Thanks!',
  'Where\'s the beef?',
  'What a stupid idea.'
]

##
# 1: Create an array to hold comments
#    that pass our filter
##
# array_goes_here

##
# Here we iterate over each comment
# and check whether they contain a word
# in our blacklist of words
##
raw_comments.each do |comment|
  unless comment.include?('stupid') # <-- This works because you can treat strings like arrays in Ruby
    ##
    # 2: How do you get the good comments into
    #    the array you created in step 1?
    ##
  else
    puts "MEAN COMMENT DETECTED: #{comment}"
  end
end

# Output the comments that weren't caught by our filter
puts filtered_comments