module PostsHelper
  # determine the text to be displayed for votes
  def vote_text post_id
    vote_count = vote_count post_id
    user_voted = user_voted? post_id

    if vote_count == 1 and user_voted
      "You have voted"
    elsif vote_count == 1 and !user_voted
      "One other person has voted"
    elsif vote_count == 2 and  user_voted
      "You and one other person have voted"
    elsif vote_count > 2 and  user_voted
      "You and " + (vote_count - 1).to_s + " other people have voted"
    elsif vote_count > 0
      vote_count.to_s + " other people have voted"
    else
      "0 votes"
    end
  end

  #has the current user voted for a post
  def user_voted? id
    if Vote.count(:conditions => { :post_id => id, :user_id => current_user.id }) > 0
      true
    else
      false
    end
  end

  #get the number of posts for a vote
  def vote_count id
    Vote.count(:conditions => { :post_id => id })
  end
end
